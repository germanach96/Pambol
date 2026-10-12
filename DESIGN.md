# Pambol: diseño visual

Documentado a partir de `jugada-mockup.html`. Dirección: **fut 5 de noche, como app de Apple**. Una cancha plana, sin luz simulada y de superficie elegible, presentada como una tarjeta de esquinas redondeadas sobre una noche que se tiñe con los colores de los dos equipos. Alrededor, el lenguaje de iOS en modo oscuro: tipografía del sistema, materiales translúcidos, controles segmentados y listas agrupadas. La app no se disfraza de herramienta: la cancha es la interfaz.

## Firmas

1. **Huellas de tachones.** Mi carrera recomendada se dibuja como huellas naranjas alternadas (suela + talón) con un filo oscuro (`rgba(20,10,0,.45)`) para leerse sobre madera y tierra, que aparecen paso a paso, y termina en un **cono de entrenamiento** real que cae en el lugar.
2. **Colas de cometa.** Al animar, la cancha se atenúa (capa `#020806` al 55 %) y cada jugador arrastra solo su último tramo: 0,8 s los jugadores, 0,45 s la pelota, en 10 trozos que se afinan y se apagan hacia atrás. Quien corre más deja la cola más larga; quien se para, la recoge. Nada queda dibujado al final.
3. **Equipaciones de verdad.** Cada equipo elige estilo (lisa, rayas, bandas, mitades, V de Vélez o Veracruz, franja horizontal de Boca, banda cruzada de River), color base y contorno. El contorno es a la vez el aro visible de la ficha y el segundo color del estilo; las tres formas de una pieza (`SHAPES`) se recortan al círculo y se pintan con él.
4. **La noche de los dos equipos.** El fondo no es negro liso: el color del rival entra desde arriba y el mío desde abajo, y al cambiar una equipación el tinte se desliza en 500 ms.
5. **Flechas ligeras.** Línea blanca fina (0,1 m) con punta pequeña y un ribete oscuro para leerse sobre el pasto. El largo dice la velocidad (parado 1,5 · trote 2,2 · media 3,3 · sprint 4,6 m). Sin cuña ni líneas de velocidad.

## Tokens

| Token | Valor | Uso |
|---|---|---|
| `--night` | `#0a0a0c` | Noche de fondo (y `theme-color`), base de los degradados de equipo |
| `--sheet` / `--sheet-solid` | `rgba(30,30,32,.72)` / `#1e1e20` | Hoja translúcida; la sólida es la alternativa sin transparencias y el hueco de las muestras elegidas |
| `--sheet-2` / `--sheet-3` | `rgba(118,118,128,.24)` / `rgba(118,118,128,.42)` | Rellenos de iOS: botones, pista del segmentado, lista de jugadas / estado pulsado |
| `--thumb` | `#5b5b60` | Pastilla elevada del control segmentado |
| `--line` | `rgba(84,84,88,.6)` | Separadores finos (0,5 px) dentro de la hoja y la lista |
| `--ink` / `-2` / `-3` | `#f5f5f7` / `rgba(235,235,245,.7)` / `rgba(235,235,245,.56)` | Etiquetas de iOS: principal, secundaria, terciaria |
| `--cone` / `--cone-2` / `--cone-ink` | `#ff9f0a` / `#ffb340` / `#1f1300` | **Único acento**, el naranja del sistema: lo que tú haces (huellas, cono, aro de "tú", Animar, selección, foco). La etiqueta "tú" va en blanco con halo oscuro para leerse sobre el pasto |
| `--miss` | `#ff453a` | Solo "Evita" y el aviso de equipos parecidos |
| `--mine` / `--rival` | por defecto `#d8263b` / `#5cb8ec` | Registrados con `@property` (`<color>`) y con transición de 500 ms. Se recalculan desde la equipación. Pintan el fondo, las zonas y las colas |
| `--material` | `blur(30px) saturate(180%)` | Material de la hoja, el aviso y los toasts |
| Paleta de equipaciones (`COLORS`, 10) | blanco `#f3efe6`, negro `#1c1f22`, rojo `#d8263b`, granate `#7d1d2f`, rosa `#ec6fa6`, naranja `#f07a1a`, amarillo `#f2c94c`, verde `#1f8a4c`, celeste `#5cb8ec`, azul `#1f3f8f` | Base y contorno de cada equipo. Por defecto: mío rayas rojo/blanco, rival liso celeste con contorno azul |
| Porteros | `#6d4dff` (míos), `#c6ef3f` (rivales) | Siempre lisos, con el contorno de su equipo |
| Dorsal | `#ffffff` o `#10171a` | El que mejor contraste con el peor color bajo el número; halo del tono contrario, más grueso cuanto peor el contraste (0,06 / 0,11 / 0,16) |
| Superficies (`SURFACES`) | césped franjas de 4 m `#2a743b` / `#276d37` (por defecto); sintético franjas de 2 m `#2e8c47` / `#2a8141`; tierra franjas de 1,5 m `#9a5b3c` / `#935739`; concreto `#6c7075` con juntas cada 5 m `rgba(0,0,0,.24)`; madera tablones de 0,5 m en `#a06c3b` / `#97653a` / `#a87444` con juntas `rgba(40,20,5,.14)`; pista azul `#2d6299` con borde `#1f4570` | SVG plano, recortado con `turfClip` (rx 1,2 m). Las líneas siguen blancas en todas: `rgba(246,248,240,.8)` de 0,12 m |

Radios: controles 12 px (`--r-ctl`), pista del segmentado 11 px y su pastilla 9 px, hoja 28 px (`--r-sheet`; 24 px flotando en escritorio), aviso, toasts y botón de cabecera 999 px, camisetas y muestras de color en círculo, muestras de superficie 12 px con vista de 7 px, cancha 1,2 m.

## Fondo

`--night` con tres capas. Móvil: radial de `--rival` al 52 % desde arriba a la izquierda (120 % × 60 % en 10 % −12 %), radial de `--mine` al 52 % desde abajo a la derecha (en 90 % 112 %), ambos hasta transparente al 68 %, y un lineal vertical suave (cada color al 10 % sobre la noche en sus extremos). Escritorio: radiales de 60 % × 55 % al 50 % anclados sobre cada portería (35 % −8 % para el rival, 35 % 108 % para el mío) y el lineal vertical. Las mezclas se hacen con `color-mix(in oklab, …)`.

`color-scheme: dark` en la raíz: controles nativos y barra de desplazamiento (fina, `--sheet-3`) en oscuro.

## Tipografía

- **Sistema, sin fuentes descargadas.** `--body`: `-apple-system`, SF Pro Text, `system-ui` y equivalentes. `--cond`: `ui-rounded`, SF Pro Rounded, y el sistema como respaldo.
- **Redondeada (`--cond`)** para la marca `pambol` (800, 28 px; 32 px en escritorio; −0,035 em), la cifra grande (700, 44 px), el reloj de la repetición (700, 42 px), los dorsales y los tiempos de la lista de eventos.
- **Texto (`--body`)** para todo lo demás, en **minúscula de oración**: cuerpo 400 16 px / 1,45 con −0,011 em; título de la hoja 700 23 px (26 px en escritorio); Animar 600 17 px; segmentos 500 14 px (600 el elegido); filas de jugadas 400 16 px; leyendas de grupo 500 13 px en `--ink-2`. Sin etiquetas en mayúsculas con interletra.
- Interletra negativa del estilo de Apple en la interfaz, pero `#pitch text` va con `letter-spacing: 0`: en un SVG escalado el tracking heredado se redondea mal.
- Cifras con `tabular-nums`.

## Íconos

Phosphor (bold y fill) incrustados como SVG: play, pause, arrow-counter-clockwise, arrow-u-up-left, stack-simple (zonas), sliders-horizontal (Ajustes), caret-up. Las pestañas de Ajustes son solo texto. Favicon incrustado en data URI: el cono sobre la noche, en un cuadrado redondeado.

## Profundidad

La cancha y las fichas son planas: sin lámparas, sin sombras proyectadas, sin brillo esférico, sin luz, viñeta ni grano en ninguna superficie: cada una es solo su color y su textura real (franjas, juntas o tablones). Las fichas se separan por color, el aro de contorno y un filo oscuro fino. Lo que flota sobre la cancha (hoja, aviso, toasts) es **material translúcido** (`--material`) con un filo de luz arriba (`inset 0 .5px 0 rgba(255,255,255,.14)`) y una sombra ambiental negra suave (hoja `0 -12px 40px` al 30 %, en escritorio `0 24px 60px` al 35 %; aviso `0 10px 30px` al 30 %). La pastilla del segmentado lleva la sombra corta de iOS. Con `prefers-reduced-transparency` todo pasa a sólido: hoja `#1e1e20`, aviso y toasts `#2c2c2e`, sin desenfoque.

## Movimiento

- Curvas: `--ease-out: cubic-bezier(0.23,1,0.32,1)`, `--ease-drawer: cubic-bezier(0.32,0.72,0,1)`; soltar ficha y caer el cono: `cubic-bezier(0.34,1.36,0.64,1)`.
- Tinte del fondo: `--mine` y `--rival` hacen transición de 500 ms al cambiar la equipación.
- Superficie: la nueva entra fundiéndose sobre la anterior en 240 ms (`drawTurf`) y la elección se guarda en `localStorage` (`pambol.surface`).
- Pulsar: los controles encogen (0,92 a 0,97) en 160 ms; segmentos y filas cambian de relleno en 160 a 200 ms.
- Levantar ficha: solo crece (escala 1,12 en 160 ms); soltar 260 ms.
- Huellas: 200 ms cada una, escalonadas 45 ms. Cono: 300 ms tras la última huella.
- Pase: línea de puntos que "rueda" hacia el receptor (0,9 s lineal, en bucle).
- Arrastre: el destino se desliza (~70 ms, interrumpible).
- Cambio de jugada: cada ficha y la pelota van a su sitio con un muelle críticamente amortiguado (respuesta 0,4 s, sin rebote), interrumpible conservando la velocidad. La recomendación se dibuja al llegar, con el aviso "Tú eres el N".
- Hoja: al crecer en el móvil sube desde abajo (300 ms, `--ease-drawer`); al encoger solo se funde (180 ms).
- Entrada: la superficie aparece en 260 ms y las fichas caen escalonadas 35 ms (300 ms cada una, desde 120 ms).
- Repetición: 60 Hz interpolada, atenuado 320 ms al entrar y 220 ms al salir, subtítulos que suben 220 ms, ½× opcional.
- `prefers-reduced-motion`: sin bucles, sin caídas ni muelles; solo fundidos (también el cambio de jugada).

## Disposición

- Móvil: barra con `pambol` y "Tú eres" (camisetas de mi equipo con su equipación), la cancha como tarjeta a casi todo el ancho (10 px de margen), hoja inferior translúcida con asa, título, una cifra grande, Animar y botones de ícono (zonas, deshacer, volver, Ajustes); "Por qué" despliega razón, Después, Alternativa y Evita, separados por una línea fina.
- **Ajustes** reemplaza el contenido de la hoja: control segmentado de iOS con cuatro pestañas solo de texto, Jugadas · Mi equipo · Rival · Cancha (pista gris, pastilla `--thumb` elevada). Jugadas es una **lista agrupada** de las siete prefabricadas (filas de 48 px, separadores de 0,5 px que empiezan a 16 px, la elegida en naranja). Cada equipo tiene Camiseta (rejilla de 4 × 2: vista previa de 44 px en la primera celda y los siete estilos de 56 px de alto), Color y Contorno (10 muestras en rejilla de 5 × 2, botones de 44 px con círculo de 28 px), aviso si los equipos se parecen e intensidad 1/2/3 para todo el equipo. Cancha muestra las seis superficies en rejilla de 3 × 2 (vista de 46 px; la elegida con aro interior de 2 px en `--ink`).
- Repetición: reloj, subtítulo, barra de tiempo de iOS (pista de 4 px, progreso naranja, pulgar blanco de 22 px), eventos y el botón **"Desde aquí"** para seguir la jugada desde ese momento.
- Escritorio (≥ 960 px): la hoja flota a la derecha (384 px, radio 24 px) con los detalles abiertos; la cancha ocupa el resto.
