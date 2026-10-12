# Pambol — especificación para construir la app

## Objetivo

Construir **Pambol**, una app de pizarra táctica de fútbol 5 que funcione como **un único archivo `index.html`** abierto directamente en el navegador del ordenador (doble clic, sin servidor, sin instalar nada).

El usuario dibuja una situación de juego (posiciones, dirección, velocidad e intensidad de los 10 jugadores, la pelota y quién es él) y la app le dice **cuál es la mejor jugada que puede hacer**, una alternativa y qué debe evitar, dibujándolo sobre la cancha.

Si en esta carpeta existe `jugada-mockup.html`, úsalo como referencia visual (colores, tipografía, disposición de la cancha y de la tarjeta de resultado). La app final debe parecerse a ese boceto, pero con el nombre **Pambol** en la cabecera y en el `<title>` (el boceto dice "Jugada", que era un nombre provisional).

## Restricciones técnicas

- Un solo archivo `index.html` con HTML, CSS y JavaScript dentro. Sin frameworks, sin paso de build, sin npm.
- Debe funcionar **sin conexión**. El análisis principal se hace 100 % en local.
- Dibujo de la cancha con **SVG** (o canvas si lo ves claramente mejor), escalable.
- Fuentes: intentar cargar Barlow / Barlow Condensed de Google Fonts, con `system-ui` como respaldo si no hay conexión.
- Diseño pensado para escritorio, pero que también se vea bien en un móvil en vertical.
- Código organizado en secciones claras dentro del `<script>`: modelo de datos, física, motor de análisis, render, interacción, integración opcional con Claude.

## La cancha

- Fútbol 5: **40 m de largo × 20 m de ancho**. Coordenadas en metros.
- `x` de 0 a 20 (ancho), `y` de 0 a 40 (largo).
- Mi equipo ataca **hacia arriba** en pantalla: portería rival en `y = 40`, la mía en `y = 0`.
- Dibujar: líneas de banda, línea central, círculo central, áreas (semicírculo de ~6 m) y porterías (3 m de ancho).
- Césped con franjas de corte alternas, como en el mockup.

## Modelo de datos

```js
state = {
  players: [
    {
      id: "a1", team: "mine" | "rival", number: 7,
      isGoalkeeper: false,
      isMe: false,              // exactamente un jugador de "mine" tiene isMe = true
      pos: { x, y },            // metros
      dir: { x, y },            // vector unitario de dirección (0,0 si está parado)
      speed: "parado" | "trote" | "media" | "sprint",
      intensity: 1 | 2 | 3      // 1 = relajado, 2 = normal, 3 = máximo esfuerzo
    }
    // 5 de cada equipo
  ],
  ball: { pos: { x, y }, ownerId: "a3" | null },
  myFoot: "derecha" | "izquierda",
  result: null                  // último análisis
}
```

Equivalencias de velocidad actual (m/s): parado 0, trote 3, media 5, sprint 7.

La intensidad modifica cómo reacciona cada jugador:

| Intensidad | Tiempo de reacción | Velocidad máxima |
|---|---|---|
| 1 relajado | 0,6 s | 5,5 m/s |
| 2 normal | 0,4 s | 6,5 m/s |
| 3 máximo | 0,25 s | 7,5 m/s |

Deja estos valores en un objeto `CONFIG` al principio del script para poder ajustarlos.

## Interacción (modo Dibujar)

- Al abrir, cargar una **formación por defecto** (2-2 + portero en cada equipo) con la pelota en mis pies.
- Barra de herramientas: **Mover**, **Dirección**, **Pelota**, **Deshacer**, **Reiniciar**.
  - *Mover*: arrastrar jugadores y pelota.
  - *Dirección*: arrastrar desde un jugador para dibujar su flecha. La longitud de la flecha fija la velocidad (cortísima = parado, corta = trote, media = media, larga = sprint), con saltos discretos.
  - *Pelota*: clic en un jugador para dársela, o en cualquier punto para dejarla suelta.
- Clic en un jugador abre un pequeño panel para: cambiar dorsal, marcar "Soy yo", cambiar intensidad (1-3), marcar portero.
- Selector de pierna buena del usuario.
- Interruptor **Dibujar / Análisis**, como en el mockup.
- Deshacer con historial de al menos 30 pasos (también con Ctrl+Z).
- Las flechas de dirección se dibujan en blanco; su longitud refleja la velocidad.
- Yo marcado con aro dorado y etiqueta "Tú".

## Motor de análisis (local, sin IA)

Se ejecuta al pulsar **Analizar**. Si yo no tengo la pelota, analizar como si la recibiera ahora mismo en su posición (avisarlo en la tarjeta).

### 1. Tiempo de llegada de un jugador a un punto

Modelo simple y explicable:

1. Durante su tiempo de reacción, el jugador sigue moviéndose con su velocidad y dirección actuales.
2. Después corre en línea recta al punto a su velocidad máxima.

`timeToReach(player, point)` devuelve segundos. Al portero rival no se le permite salir más allá de ~8 m de su portería.

### 2. Opciones candidatas

Generar todas estas:

- **Pase al pie** de cada compañero (excepto mi portero salvo que no haya otra opción).
- **Pase al espacio**: puntos en una rejilla cada 2 m, a menos de 25 m de mí. Solo cuenta si algún compañero llega a ese punto antes que cualquier rival.
- **Conducción**: 8 direcciones, avanzar 4 m.
- **Tiro**: si estoy a menos de 18 m de la portería rival.
- **Proteger / pausar**: quedarme con la pelota de espaldas (opción de bajo riesgo y bajo valor).

### 3. Evaluación de un pase

- Velocidad del balón: pase raso 11 m/s (en `CONFIG`). Pase con la pierna mala: 10 % más lento y 15 % menos preciso.
- `tBall(t)` = tiempo en que la pelota llega a cada punto de la trayectoria.
- **Intercepción**: muestrear la línea de pase cada 0,5 m; si algún rival llega a un punto antes que la pelota (con margen de 0,15 s), el pase es interceptable allí.
- **Recepción**: margen = (tiempo del rival más rápido al punto destino) − (tiempo del receptor al punto destino).
- Probabilidad de éxito: función logística sobre el peor margen (intercepción en trayecto y en destino). Ejemplo: `p = 1 / (1 + exp(-4 * margen))`.

### 4. Evaluación de conducción y tiro

- **Conducción**: el éxito depende de la ventaja que saco a los rivales al punto destino (mi velocidad con balón = 85 % de mi máxima).
- **Tiro**: valor según distancia y ángulo a la portería; probabilidad reducida por rivales en el triángulo pelota-postes y por la posición del portero.

### 5. Valor de la posición

Mapa de valor de la cancha (tipo *expected threat* simplificado): más valor cuanto más cerca de la portería rival y más centrado; bonus si el receptor queda de frente a portería (se mueve hacia arriba).

### 6. Puntuación y elección

```
puntuación = probabilidadDeÉxito × valorDestino − probabilidadDePérdida × costeDePérdida
```

- `costeDePérdida` es mayor cuanto más cerca de mi propia portería se pierda el balón.
- **Mejor jugada**: la de mayor puntuación.
- **Alternativa**: la mejor de un tipo distinto (si la mejor es pase, la alternativa es conducción o tiro, y viceversa).
- **Evita**: la opción más "tentadora" pero mala: el pase al compañero más cercano o más adelantado con mayor riesgo de intercepción.

### 7. Explicación en texto (generada en local)

Construir frases a partir de los datos, por ejemplo:
"El 7 ya va en sprint por la derecha y el 5 rival recula. Llega 1,1 s antes que nadie al balón."

Mostrar también 3 datos clave: ventaja en segundos, riesgo (Bajo / Medio / Alto) y distancia del pase o conducción.

## Visualización del resultado (modo Análisis)

- Jugada recomendada: flecha **dorada discontinua** (curva suave para pases al espacio) y círculo dorado translúcido en el destino.
- Opción a evitar: flecha rosa discontinua con una ✕ en el punto de intercepción y una **zona rosa translúcida** que muestre por dónde la corta el rival.
- Alternativa: flecha fina gris clara.
- Botón opcional **Ver zonas**: mapa de calor de qué equipo controla cada zona (para cada celda, quién llega antes), con poca opacidad.
- Tarjeta inferior como en el mockup: título de la jugada, explicación, 3 datos, Alternativa, Evita, y botones **Explicar con Claude** y **Nueva jugada**.

## Integración opcional con Claude

Botón **Explicar con Claude**. Es la única parte que necesita internet.

- En un panel de ajustes, el usuario pega su API key de Anthropic. Guardarla en `localStorage` solo si marca "Recordar en este ordenador", y avisar de que queda guardada en el navegador.
- Llamada directa desde el navegador:
  - `POST https://api.anthropic.com/v1/messages`
  - Cabeceras: `x-api-key`, `anthropic-version: 2023-06-01`, `content-type: application/json`, `anthropic-dangerous-direct-browser-access: true`
  - Modelo: `claude-haiku-5-5` por defecto (configurable en ajustes), `max_tokens` 400.
- Enviar un JSON compacto con: la situación (posiciones en metros, velocidades, intensidades), las 3 mejores opciones del motor local con sus números, y pedirle que explique en español, en 4-5 frases, por qué la mejor opción es la mejor y qué tendría que vigilar el jugador. Pedirle que **no contradiga los cálculos** salvo que vea un error claro, y que en ese caso lo diga.
- Mostrar la respuesta en la tarjeta. Si no hay key o no hay conexión, mostrar un mensaje claro de qué falta. Nunca bloquear el resto de la app.

## Extras (solo cuando lo anterior funcione)

1. Guardar y cargar jugadas con nombre (`localStorage`) y exportar/importar como JSON.
2. Escenarios de ejemplo precargados (contraataque 3 contra 2, salida de balón presionada, balón suelto en medio campo).
3. Animación de 1-2 segundos que simule cómo evolucionaría la jugada recomendada.

## Orden de trabajo

1. Cancha y render de jugadores con la formación por defecto.
2. Interacción de dibujo (mover, dirección, pelota, panel de jugador, deshacer).
3. Física de tiempos de llegada + botón temporal que muestre el mapa de zonas, para verificar visualmente que el modelo tiene sentido.
4. Motor de opciones y puntuación.
5. Visualización del resultado y tarjeta.
6. Integración opcional con Claude.
7. Extras.

Después de cada paso, abre `index.html` en el navegador y comprueba que funciona antes de seguir.

## Criterios de aceptación

- Abro `index.html` con doble clic, sin internet, y puedo dibujar una jugada y analizarla.
- En el escenario del mockup (yo con la pelota en el centro-izquierda, el 7 en sprint por la derecha, el 9 marcado por el 4 rival), la recomendación es el pase al espacio al 7 y la opción a evitar es el pase al 9.
- Si pongo a un rival en sprint cortando la línea de un pase, ese pase deja de ser la recomendación.
- Si estoy solo frente a portería a menos de 10 m, la recomendación es tirar.
- Todos los parámetros de física y puntuación están en `CONFIG` y se pueden cambiar sin tocar el resto del código.
