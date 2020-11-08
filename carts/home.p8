pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- home carbon
-- Capitol Technology University Senior CS Project

buttons = {
  left = 0,
  right = 1,
  up = 2,
  down = 3,
  o = 4,
  x = 5
}

-- change this constant to change modes
game = "outside"

-- frame timer, incremented each update
t = 0

show_alternatives = false

outdoor_items = {
  trash = {
    sprite_start = 7,
    x = 72,
    y = 108,
    size = 16
  }
}

item_selection = outdoor_items.trash

function _update()
  t = time()
  if (game == "outside")
  then
    updateOutside()
  end
end

function _draw()
  cls()
  if (game == "outside")
  then
    drawOutside()
  end
end

function drawOutside()
  map(0, 0, 0, 0, 16, 16)
  drawTrash()
  if (t % 2 < 1 and show_alternatives == false)
  then
    color(14)
    local highlight_x = item_selection.x
    local highlight_y = item_selection.y
    local size = item_selection.size
    rect(highlight_x, highlight_y, highlight_x + size, highlight_y + size)
  end
  if (show_alternatives == false and btnp(buttons.o))
  then
    show_alternatives = true
  elseif (show_alternatives == true and btnp(buttons.x))
  then
    show_alternatives = false
  end
  if (show_alternatives)
  then
    -- show alternative selection for current item
    color(8)
    print("test", 64, 64)
  end
end

function drawTrash()
  spr(outdoor_items.trash.sprite_start, outdoor_items.trash.x, outdoor_items.trash.y)
  spr(outdoor_items.trash.sprite_start + 1, outdoor_items.trash.x + 8, outdoor_items.trash.y)
  spr(outdoor_items.trash.sprite_start + 2, outdoor_items.trash.x, outdoor_items.trash.y + 8)
  spr(outdoor_items.trash.sprite_start + 3, outdoor_items.trash.x + 8, outdoor_items.trash.y + 8)
end

function updateOutside()
  _draw()
end

__gfx__
0000000033333333cccccccc0005000566666666dddddddd66666660000000000000000000011611611610000000000000000000000bb6bb6bb6b00000000000
00000000333333b3cccccccc0005000564444444dddddddd64666666000000000000000000011611611610000000000000000000000bb6bb6bb6b00000000000
0000000033333333cccccccc0005000564444444ddddddddd660666f0066666666666000000016116161000000666666666660000000b6bb6b6b000000000000
00000000b3333333cccccccc555555556444444455555555666664660666666666666660000011616161000006666666666666600000bb6b6b6b000000000000
0000000033333333cccccccc5000500066666666dddddddd6f6666660666666666666660000011616161000006666666666666600000bb6b6b6b000000000000
0000000033333333cccccccc5000500044464444dddddddd666766060011611161161100000001616160000000bb6bbb6bb6bb0000000b6b6b60000000000000
000000003333b333cccccccc5000500044464444dddddddd6066666600016111611610000000011111100000000b6bbb6bb6b00000000bbbbbb0000000000000
0000000033333333cccccccc5555555544464444dddddddd666d667600011611611610000000000000000000000bb6bb6bb6b000000000000000000000000000
66666660666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
64666666646666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d66068888888666f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666668ccccc864660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f6668ccccc866660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666768ccccc866060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
606668ccccc866660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66688888888888760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66688888888888600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6468aa88888aa8660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d658aa88888aa85f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66555555555555560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f600555555600660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66600606666700060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60666666606666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666d6676666d66760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666660666666606666666066666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
64666666646666666466666664666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d660666fd660666fd660666fd660666f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666466666664666666646666666466000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f6666666f6666666f6666666f666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66676606666766066667660666676606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60666666606666666066666660666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666d6676666d6676666d6676666d6676000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666660666666606666666066666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
64666666646666666466666664666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d660666fd660666fd660666fd660666f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666466666664666666646666666466000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f6666666f6666666f6666666f666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66676606666766066667660666676606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60666666606666666066666660666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666d6676666d6676666d6676666d6676000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666660666666606666666066666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
64666666646666666466666664666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d660666fd660666fd660666fd660666f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666466666664666666646666666466000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f6666666f6666666f6666666f666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66676606666766066667660666676606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60666666606666666066666660666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666d6676666d6676666d6676666d6676000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6666666066666660666666606766d666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
64666666646666666466666666666606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d660666fd660666fd660666f60667666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666664666666646666666466666666f6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f6666666f6666666f66666666466666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666766066667660666676606f666066d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60666666606666666066666666666646000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666d6676666d6676666d667606666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000004040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000
__map__
0202020202020202020202020202020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0202020202020203020202020202020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0202020202020303030302020202020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0202020203030303030303020202020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0202020303030303030303030302020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0202030303030303030303030303020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0202020404040404040404040402020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0202020405050505040404040402020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0202020405050505040404040402020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0202020405050505040404040402020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0202020405050505040404040402020200000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0101010106060606010101010101010100000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0101010106060606010101010101010100000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0101010106060606010101010101010100000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0101010106060606010101010101010100000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0101010106060606010101010101010100000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
