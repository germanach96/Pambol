# Pambol: diseño visual

Documentado a partir de `jugada-mockup.html`. Dirección: **fut 5 de noche**. La cancha sintética del barrio bajo cuatro lámparas, rodeada por la malla de la jaula. La app no se disfraza de herramienta: la cancha es la interfaz.

## Firmas

1. **Sombras de lámpara.** Cada ficha, la pelota y el cono proyectan cuatro sombras suaves, una por lámpara de esquina. Al levantar una ficha las sombras se alargan y se aclaran; al soltarla vuelven.
2. **Huellas de tachones.** Mi carrera recomendada se dibuja como huellas naranjas alternadas (suela + talón) que aparecen paso a paso, y termina en un **cono de entrenamiento** real que cae en el lugar.
3. **Exposición larga.** Al animar, las lámparas bajan (capa oscura al 55 %) y cada jugador deja una estela de luz de su color, como una foto nocturna de larga exposición. Al final queda la jugada entera "fotografiada".
4. **Flechas de pincel.** La dirección es una cuña que se afina hacia donde va el jugador; en media y sprint aparecen líneas de velocidad detrás.

## Tokens

| Token | Valor | Uso |
|---|---|---|
| `--night` | `#0b1110` | Noche alrededor de la cancha (con malla de jaula en SVG) |
| `--sheet` / `-2` / `-3` | `#131c1b` / `#1b2624` / `#24322f` | Hoja inferior y controles |
| `--ink` / `-2` / `-3` | `#edf3ef` / `#b7c5be` / `#93a39c` | Texto (AA sobre la hoja) |
| `--cone` / `--cone-2` | `#ff8c1a` / `#ffb05a` | **Único acento**: lo que tú haces (huellas, cono, "tú", Animar) |
| `--miss` | `#ff6363` | Solo para "Evita" |
| `--mine` / `--mine-w` | `#d8263b` / `#f3efe6` | Camiseta rayada roja y blanca |
| `--rival` / `--rival-ink` | `#5cb8ec` / `#0a2b45` | Camiseta celeste lisa |
| Porteros | `#6d4dff` (míos), `#c6ef3f` (rivales) | |
| Pasto | canvas generado: `#28723a`, franjas de 4 m, grano, fibras, luz de 4 lámparas, centro un poco más oscuro | |

Radios: controles 14 px, hoja 24 px, avisos y fichas de texto 999 px.

## Tipografía

- **Barlow Condensed** 700–800 (cursiva 800 para la marca `pambol` y los números grandes).
- **Barlow** 400–600 para todo lo demás, en **minúscula de oración**. Sin etiquetas en mayúsculas con interletra.
- Cifras con `tabular-nums`.

## Íconos

Phosphor (bold y fill) incrustados como SVG: play, pause, arrow-counter-clockwise, arrow-u-up-left, stack-simple, caret-up.

## Movimiento

- Curvas: `--ease-out: cubic-bezier(0.23,1,0.32,1)`, `--ease-drawer: cubic-bezier(0.32,0.72,0,1)`; soltar ficha y caer el cono: `cubic-bezier(0.34,1.36,0.64,1)`.
- Huellas: 200 ms cada una, escalonadas 45 ms. Cono: 300 ms tras la última huella.
- Pase: línea de puntos que "rueda" hacia el receptor (0,9 s lineal, en bucle).
- Arrastre: el destino se desliza (~70 ms, interrumpible) con histéresis; levantar 160 ms, soltar 260 ms.
- Entrada: el pasto aparece en 260 ms y las fichas caen escalonadas 35 ms.
- Repetición: 60 Hz interpolada, estelas acumuladas, subtítulos que suben 220 ms, ½×.
- `prefers-reduced-motion`: sin bucles, sin caídas; solo fundidos.

## Disposición

- Móvil: barra con `pambol` y "Tú eres" (camisetas), cancha a todo lo ancho, hoja inferior con título, una cifra grande, Animar y tres botones de ícono; "Por qué" despliega razón, Después, Alternativa y Evita.
- Escritorio (≥ 960 px): la hoja flota a la derecha (384 px) con los detalles abiertos.
