# Pambol: diseño visual

Documentado a partir de `jugada-mockup.html`. Dirección: **fut 5 de noche**. La cancha sintética del barrio, rodeada por la malla de la jaula, dibujada plana y sin luz simulada. La app no se disfraza de herramienta: la cancha es la interfaz.

## Firmas

1. **Huellas de tachones.** Mi carrera recomendada se dibuja como huellas naranjas alternadas (suela + talón) que aparecen paso a paso, y termina en un **cono de entrenamiento** real que cae en el lugar.
2. **Colas de cometa.** Al animar, la cancha se atenúa (capa `#020806` al 55 %) y cada jugador arrastra solo su último tramo: 0,8 s los jugadores, 0,45 s la pelota, en 10 trozos que se afinan y se apagan hacia atrás. Quien corre más deja la cola más larga; quien se para, la recoge. Nada queda dibujado al final.
3. **Equipaciones de verdad.** Cada equipo elige estilo (lisa, rayas, bandas, mitades), color base y contorno. El contorno es a la vez el aro visible de la ficha y el segundo color del estilo.
4. **Flechas ligeras.** Línea blanca fina (0,1 m) con punta pequeña y un ribete oscuro para leerse sobre el pasto. El largo dice la velocidad (parado 1,5 · trote 2,2 · media 3,3 · sprint 4,6 m). Sin cuña ni líneas de velocidad.

## Tokens

| Token | Valor | Uso |
|---|---|---|
| `--night` | `#0b1110` | Noche alrededor de la cancha (con malla de jaula en SVG) |
| `--sheet` / `-2` / `-3` | `#131c1b` / `#1b2624` / `#24322f` | Hoja inferior, controles, estado pulsado |
| `--line` | `rgba(214,236,226,.1)` | Separadores dentro de la hoja |
| `--ink` / `-2` / `-3` | `#edf3ef` / `#b7c5be` / `#93a39c` | Texto (AA sobre la hoja) |
| `--cone` / `--cone-2` / `--cone-ink` | `#ff8c1a` / `#ffb05a` / `#241102` | **Único acento**: lo que tú haces (huellas, cono, "tú", Animar, selección) |
| `--miss` | `#ff6363` | Solo "Evita" y el aviso de equipos parecidos |
| `--mine` / `--rival` | por defecto `#d8263b` / `#5cb8ec` | Se recalculan desde la equipación: el color base, o el contorno si la base es casi negra. Pintan zonas y colas |
| Paleta de equipaciones | blanco `#f3efe6`, negro `#1c1f22`, rojo `#d8263b`, granate `#7d1d2f`, celeste `#5cb8ec`, azul `#1f3f8f`, amarillo `#f2c94c`, verde `#1f8a4c` | Base y contorno de cada equipo. Por defecto: mío rayas rojo/blanco, rival liso celeste con contorno azul |
| Porteros | `#6d4dff` (míos), `#c6ef3f` (rivales) | Siempre lisos, con el contorno de su equipo |
| Dorsal | `#ffffff` o `#10171a` | El que mejor contraste con el peor color bajo el número; halo del tono contrario, más grueso cuanto peor el contraste (0,06 / 0,11 / 0,16) |
| Pasto | SVG plano: franjas de 4 m `#2a743b` / `#276d37`, líneas `rgba(246,248,240,.8)` de 0,12 m | |

Radios: controles 14 px (segmentos internos 10 px), hoja 24 px, avisos, chips y muestras de color 999 px.

## Tipografía

- **Barlow Condensed** 700 a 800 (cursiva 800 para la marca `pambol`, la cifra grande y el reloj de la repetición; 700 para títulos, dorsales y Animar).
- **Barlow** 400 a 600 para todo lo demás, en **minúscula de oración**. Sin etiquetas en mayúsculas con interletra.
- Cifras con `tabular-nums`.

## Íconos

Phosphor (bold y fill) incrustados como SVG: play, pause, arrow-counter-clockwise, arrow-u-up-left, stack-simple, sliders-horizontal, caret-up. Favicon incrustado en data URI: el cono sobre la noche.

## Profundidad

Plana. Sin lámparas, sin sombras proyectadas, sin brillo esférico en fichas ni pelota, sin luz, viñeta ni grano en el pasto. Las fichas se separan del pasto por color, el aro de contorno y un filo oscuro fino. Solo flotan sobre la cancha la hoja, el aviso y los toasts, con una sombra ambiental suave.

## Movimiento

- Curvas: `--ease-out: cubic-bezier(0.23,1,0.32,1)`, `--ease-drawer: cubic-bezier(0.32,0.72,0,1)`; soltar ficha y caer el cono: `cubic-bezier(0.34,1.36,0.64,1)`.
- Levantar ficha: solo crece (escala 1,12 en 160 ms); soltar 260 ms.
- Huellas: 200 ms cada una, escalonadas 45 ms. Cono: 300 ms tras la última huella.
- Pase: línea de puntos que "rueda" hacia el receptor (0,9 s lineal, en bucle).
- Arrastre: el destino se desliza (~70 ms, interrumpible).
- Cambio de jugada: cada ficha y la pelota van a su sitio con un muelle críticamente amortiguado (respuesta 0,4 s, sin rebote), interrumpible conservando la velocidad. La recomendación se dibuja al llegar, con el aviso "Tú eres el N".
- Hoja: al crecer en el móvil sube desde abajo (300 ms, `--ease-drawer`); al encoger solo se funde (180 ms).
- Entrada: el pasto aparece en 260 ms y las fichas caen escalonadas 35 ms (300 ms cada una, desde 120 ms).
- Repetición: 60 Hz interpolada, atenuado 320 ms al entrar y 220 ms al salir, subtítulos que suben 220 ms, ½× opcional.
- `prefers-reduced-motion`: sin bucles, sin caídas ni muelles; solo fundidos (también el cambio de jugada).

## Disposición

- Móvil: barra con `pambol` y "Tú eres" (camisetas de mi equipo con su equipación), cancha a todo lo ancho, hoja inferior con título, una cifra grande, Animar y cuatro botones de ícono (zonas, deshacer, volver, jugadas y equipos); "Por qué" despliega razón, Después, Alternativa y Evita.
- **Jugadas y equipos** reemplaza el contenido de la hoja: pestañas Jugadas · Mi equipo · Rival. Jugadas lista las siete prefabricadas; cada equipo tiene vista previa de la ficha, estilo, Color, Contorno (8 muestras), aviso si los equipos se parecen e intensidad 1/2/3 para todo el equipo.
- Escritorio (≥ 960 px): la hoja flota a la derecha (384 px) con los detalles abiertos.
