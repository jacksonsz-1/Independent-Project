FREE PIXEL LOOPS
20 looping pixel art fires, smoke columns and magic auras for 2D games

What's in here
  flames/   7 fire loops: fire at 32, 48 and 64 px, and blue (frost),
            green (toxic), violet (arcane) and gold at 48 px
  smoke/    6 smoke loops: gray at 32, 48 and 64 px, and dust, green
            (toxic) and steam at 48 px
  auras/    7 aura loops (a glowing ring on the ground with motes rising):
            arcane at 32, 48 and 64 px, and gold, green, frost and fire
            at 48 px

32 px loops have 12 frames, 48 and 64 px have 16, all at 12 fps. They
loop with no jump: the last frame leads straight back into the first.
Set them to loop.

Every effect is a PNG sprite sheet (one row, transparent background)
with a JSON file and a Godot SpriteFrames file (.tres) of the same name
next to it. The JSON has the frame size, frame count, fps, each frame's
x/y, the palette, and "loop": true. File names say the size:
flame-fire-64.png is 64 x 64 per frame.

Godot 4
  Copy the folder into your project, add an AnimatedSprite2D, drag a
  .tres onto its Sprite Frames, and turn on Autoplay (or call play()).
  The .tres already loops at the right speed. Set Texture Filter to
  Nearest or they'll look blurry. Tested in Godot 4.3, 4.5 and 4.7.

Unity
  Import the PNG, Texture Type: Sprite, Sprite Mode: Multiple,
  Filter Mode: Point, Compression: None. Sprite Editor > Slice >
  Grid By Cell Size, using frame_width and frame_height from the JSON.
  Drag the slices into the scene to make a looping animation.

GameMaker
  Create Sprite > Import Strip Image, number of frames = frame_count,
  and set the sprite's speed to the fps from the JSON. GameMaker loops
  sprites already.

Defold
  Make a Tile Source from the PNG with Tile Width and Tile Height set
  to the frame size, add an animation with Start Tile 1, End Tile =
  frame_count, Playback: Loop Forward, and the fps from the JSON.

License
  CC0. Use them in anything, commercial included, and change them as
  you like. No credit needed. See LICENSE.txt.

How they were made
  Drawn by code with Puff, my pixel effect generator. No generative AI
  made the pictures.

Your own colors, sizes or frame counts
  Puff, the tool that drew these, makes them in any palette you paste,
  16 to 256 px, 4 to 48 frames. It's free in the browser (GIF export);
  the $5 version exports sheets with the same JSON and Godot files:
  https://cs5475.itch.io/puff

Free pack with 30 one-shot explosions, hit sparks and magic:
  https://cs5475.itch.io/free-pixel-effects
