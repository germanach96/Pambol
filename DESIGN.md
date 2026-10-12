# Pambol: diseño visual

Documentado a partir de `jugada-mockup.html` (dirección: **Telestrator de transmisión**). La cancha es una repetición de TV congelada para analizarla; la app es el plumón del comentarista.

## Mundo

- Estudio casi negro alrededor; la cancha con franjas de corte es lo único brillante.
- Paneles tipo *score bug* / rótulo inferior de transmisión: fondo plano, línea fina, pestaña de color en un borde.
- Todo se toca directamente sobre la cancha. No hay barra de herramientas de modos.

## Tokens

| Token | Valor | Uso |
|---|---|---|
| `--bg` | `#090d12` | Fondo del estudio |
| `--panel` / `--panel-2` | `#0f161e` / `#151e29` | Rótulo inferior, botones |
| `--hair` / `--hair-2` | `rgba(255,255,255,.09)` / `.16` | Líneas y bordes |
| `--ink` / `--ink-2` / `--ink-3` | `#eef2f6` / `#a3b0bd` / `#7a8999` | Texto (AA sobre `--bg`) |
| `--gold` | `#f6c445` | **Solo** mi recomendación, "Tú", botón principal |
| `--pink` | `#ff4f8b` | Jugada a evitar, zona de intercepción |
| `--mine` / `--mine-gk` | `#e2483d` / `#8f6bff` | Mi equipo / mi portero |
| `--rival` / `--rival-gk` | `#33c2ee` / `#b8e34a` | Rivales / su portero |
| Césped | `#2f7b3b` / `#2a7135`, borde `#215a2b` | Franjas de 4 m |

## Tipografía

- **Barlow Condensed** 600–800, mayúsculas, interletra amplia: marca, títulos, etiquetas, cifras (`tabular-nums`).
- **Barlow** 400–500: explicaciones.
- Respaldo `system-ui`.

## Lenguaje sobre la cancha

- Recomendación: trazo dorado discontinuo (`.55 .38`) con curva suave + anillo dorado con pulso + etiqueta ("PONTE AQUÍ").
- Pase o tiro: línea **punteada** dorada (puntos redondos).
- Alternativa: gris claro fino discontinuo. Evita: rosa con ✕ y zona translúcida.
- Flechas de dirección blancas; su largo marca la velocidad. Jugador parado: punta tenue y punteada.
- Intensidad: barras tipo señal (1–3) a la derecha del jugador.

## Movimiento

- Curvas: `--ease-out: cubic-bezier(0.23,1,0.32,1)`, `--ease-in-out: cubic-bezier(0.77,0,0.175,1)`.
- **Firma**: la recomendación se dibuja sola como un trazo de plumón (máscara con `stroke-dashoffset`, 280 ms) y el anillo entra con 200 ms de retraso (180 ms, `scale .9→1`).
- Al arrastrar no se redibuja: el destino se desliza (aproximación exponencial de ~70 ms, interrumpible), con la línea y el anillo sobre el mismo punto, e histéresis para no saltar entre puntos casi iguales.
- Repetición: simulación a 60 Hz interpolada, estelas de 0,7 s, subtítulos que entran 200 ms desde abajo, línea de tiempo con marcas de eventos, velocidad ½×.
- `prefers-reduced-motion`: sin trazo animado, sin pulso, sin deslizamiento; la repetición se mantiene (es el contenido).

## Disposición

- Móvil (≤ 899 px): cabecera, selector "Soy el", cancha que llena el alto disponible, rótulo inferior con título, razón, 3 datos y **Animar** visible; "Detalles" plegable.
- Escritorio: cancha a la izquierda, rótulo como columna derecha de 400 px con Detalles abiertos.
