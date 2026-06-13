from PIL import Image, ImageDraw, ImageFont

chars = r"`.-':_,^=;><+!rc*/z?sLTv)J7(|Fi{C}fI31tlu[neoZ5Yxjya]2ESwqkP6h9d4VpOGbUAKXHm8RD#$Bg0MNWQ%&@"

COLS = 16
CELL_SIZE = 64

ROWS = (len(chars) + COLS - 1) // COLS

WIDTH = COLS * CELL_SIZE
HEIGHT = ROWS * CELL_SIZE

img = Image.new("L", (WIDTH, HEIGHT), 0)
draw = ImageDraw.Draw(img)

font = ImageFont.truetype(
    "/usr/share/fonts/noto/NotoSansMono-Regular.ttf",
    48
)

for i, ch in enumerate(chars):
    col = i % COLS
    row = i // COLS

    x = col * CELL_SIZE
    y = row * CELL_SIZE

    bbox = draw.textbbox((0, 0), ch, font=font)

    text_w = bbox[2] - bbox[0]
    text_h = bbox[3] - bbox[1]

    tx = x + (CELL_SIZE - text_w) / 2
    ty = y + (CELL_SIZE - text_h) / 2

    draw.text(
        (tx, ty),
        ch,
        fill=255,
        font=font
    )

img.save("ascii.png")

print(f"Generated ascii.png")
print(f"Characters: {len(chars)}")
print(f"Atlas: {WIDTH}x{HEIGHT}")
print(f"Grid: {COLS}x{ROWS}")


#this code was written by chatgpt, bcs i am lazy and wanted to generate an ascii atlas faster S