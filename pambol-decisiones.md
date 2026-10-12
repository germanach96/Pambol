# Pambol: decisiones de diseño (v2)

Este documento recoge lo que se decidió después de revisar `pambol-spec.md`. **Si contradice a la especificación, manda este documento.** Todo lo que no aparece aquí sigue igual que en la especificación.

Las preguntas de la tercera ronda (sección 3) no se contestaron explícitamente. Se adoptó la respuesta recomendada en cada una y se puede revisar más adelante.

## 1. Para qué sirve

- La usa **una sola persona** (yo), **en casa**, cuando me acuerdo de una jugada.
- Dos usos:
  - **Revisar** una jugada real que pasó en un partido (qué tendría que haber hecho).
  - **Estudiar** situaciones típicas para aprender patrones.
- **No** está pensada para usarla durante el partido.
- No es "la verdad": es un modelo. Pero tiene que incluir **reglas claras que no dejen duda**.

## 2. Alcance: las tres situaciones de juego

La app me dice **qué hago yo** en cualquiera de estos tres momentos:

| Quién tiene la pelota | Qué me recomienda la app |
|---|---|
| **Yo** | Pase al pie, pase al espacio, conducción, tiro o proteger (igual que en la especificación). |
| **Un compañero** | **Dónde ponerme**: ir al espacio o dar apoyo para recibir, **o jalar marca** para abrir hueco a otro compañero. |
| **Un rival** | **Qué hacer en defensa**: a quién marcar, presionar al que tiene la pelota, cerrar una línea de pase (cuál) o temporizar (recular hacia una zona). |

- **Detección automática**: el modo depende de quién tiene la pelota y no hay que elegirlo a mano. Se muestra un indicador visible del modo detectado ("Con balón" / "Sin balón" / "Defensa").
- **Pelota suelta**: se calcula quién llega antes. Si llego yo o un compañero, "ve a por ella". Si llega un rival, se trata como defensa.
- **Horizonte**: una sola acción inmediata, pensando en el siguiente segundo o dos. Como mucho, la explicación añade una frase del tipo "después, sigue hacia…".
- La recomendación es **solo para mí**. Los otros 9 jugadores siguen con su movimiento actual. En defensa, como contexto, se dibuja con líneas finas el reparto de marcas sugerido para todo mi equipo.

## 3. Motor: "lo mejor para el equipo"

Hay una sola métrica, que se usa en espejo:

> **Valor de equipo** = puntuación de la mejor jugada disponible para el que tiene la pelota (con el motor de la especificación, secciones 1 a 6).

- **Con balón**: igual que en la especificación.
- **Sin balón (atacando)**: se generan movimientos candidatos para mí: puntos de una rejilla alcanzables en 1 o 2 s. Para cada uno se simula mi movimiento y se recalcula el valor de equipo. Gana el movimiento que **más sube** el valor de equipo, **aunque no acabe recibiendo yo**.
  - **Ir al espacio / apoyo**: el punto donde llego antes que los rivales, con la línea de pase limpia desde el compañero y en una zona de valor.
  - **Jalar marca**: para que funcione, la app tiene que saber quién marca a quién. Por defecto, **cada rival marca al atacante más cercano**, y se puede corregir a mano en el panel del jugador. Al simular mi movimiento, mi marcador me sigue y se mide cuánto mejoran las opciones del que tiene la pelota.
- **Defensa**: el mismo motor, pero calculando las opciones del rival como si fuera el equipo atacante. Gana mi acción que **más baja** el valor de equipo del rival.

## 4. Reglas fijas ("sin duda")

Hay dos capas:

1. Primero se comprueban las **reglas fijas**. Si una se cumple, se recomienda y aparece con la etiqueta **"Regla"**.
2. Si no se cumple ninguna, decide el **cálculo**, con la etiqueta **"Cálculo"**.

Lista inicial, **provisional** (se sustituirá más adelante por la lista definitiva):

1. Solo ante el portero a menos de 10 m → tira.
2. 2 contra 1 → conduce hacia el defensor y pasa cuando se comprometa.
3. Nunca un pase horizontal delante de mi propia área con un rival a menos de 3 m de la línea.
4. Si mi marcador me sigue y hay un compañero detrás de mí → arrastra la marca hacia fuera.
5. Recibo de espaldas y presionado → apoyo de cara (devolver) y no girarme.
6. Defensa: si soy el más cercano al que tiene la pelota y llego antes de que controle → presiono.

Las reglas tienen que estar en una estructura de datos aparte (una lista de `{ id, nombre, condición, acción }`) para poder cambiarlas sin tocar el motor.

## 5. Entrada de datos: partir de escenarios

Dibujar 10 jugadores desde cero cada vez es demasiado lento. La app **arranca desde escenarios ya montados**, que luego se ajustan **arrastrando jugadores y cambiando sus parámetros** (dirección, velocidad, intensidad, marca).

- Por defecto, cada jugador está **parado y con intensidad normal**. Solo se tocan los 2 a 4 jugadores que importan.
- La intensidad va en un panel secundario, no en primer plano.

Escenarios iniciales:

1. Salida de balón presionada.
2. Contraataque 3 contra 2.
3. 2 contra 1 por banda.
4. Ataque contra bloque bajo.
5. Balón dividido en medio campo.

Esto deja de ser un extra y pasa a ser parte del núcleo. Guardar mis propias jugadas sigue siendo un extra.

## 6. Plataforma

- **Móvil primero**, en vertical y con el dedo. Las flechas de dirección y los paneles tienen que ser cómodos de usar con el dedo.
- **Ahora se prueba en el ordenador**: tiene que funcionar bien en escritorio.
- Sigue siendo **un solo `index.html`** que funcione abierto en local con doble clic. Más adelante se publica con **GitHub Pages** desde este repo para abrirlo en el móvil y añadirlo a la pantalla de inicio.

## 7. Fuera de la v1

- **"Explicar con Claude"**: eliminado (ni la API key ni la llamada a la API). La explicación se genera solo en local.
- Secuencias de varias acciones.
- Recomendaciones para los otros jugadores de mi equipo (solo como contexto en defensa).

## 8. Encargo para el mockup (siguiente conversación)

El mockup (`jugada-mockup.html`) todavía no existe y es el siguiente paso. Tiene que mostrar:

- **Pantalla de móvil en vertical** como diseño principal, y cómo se adapta a escritorio.
- **Cabecera** con el nombre **Pambol**.
- **Selector de escenario** (los 5 de la sección 5).
- **La cancha** de fútbol 5 (40 × 20 m, ataco hacia arriba, césped con franjas), con:
  - jugadores de los dos equipos con dorsal;
  - "Tú" marcado con aro dorado;
  - flechas blancas de dirección;
  - la pelota.
- **Indicador de modo** detectado: Con balón / Sin balón / Defensa.
- **Interacción táctil**: cómo se arrastra un jugador, cómo se dibuja su flecha y cómo se abre su panel (dorsal, Soy yo, portero, intensidad, a quién marca).
- **Resultado en los tres modos**:
  - Con balón: flecha dorada discontinua a la jugada recomendada, alternativa en gris y jugada a evitar en rosa con ✕ y zona de intercepción.
  - Sin balón: punto dorado de "ponte aquí" con la trayectoria. Si es jalar marca, flecha de mi movimiento y del marcador que me sigue, y el hueco que se abre resaltado.
  - Defensa: a quién marcar, línea de pase cerrada o zona a temporizar, y las líneas finas del reparto de marcas.
- **Tarjeta de resultado**: título, etiqueta **Regla / Cálculo**, explicación, 3 datos clave (ventaja, riesgo y distancia), Alternativa, Evita, y botones **Nueva jugada** y **Volver al escenario**. Sin botón de Claude.
- Interruptor **Dibujar / Análisis** y botón **Ver zonas** (mapa de quién controla cada zona).
