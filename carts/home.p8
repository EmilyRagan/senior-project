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

function hcenter(s)
  -- screen center minus the string length times the pixels in a char's width, cut in half
  return 64-#s*2
end
 
function vcenter(s)
  -- screen center minus the string height in pixels, cut in half
  return 61
end

-- frame timer, incremented each update
t = 0

-- initial display values
show_instructions = true
show_alternatives = false
show_settings = false

-- settings
settings = {
  {
    label = 'number of cars',
    minimum = 0,
    value = 1
  },
  {
    label = 'number of people',
    minimum = 1,
    value = 1
  }
}

function setDefaultData()
  -- arrays in Lua are 1-indexed, so 1st thing in options list is index 1
  -- 0 index === nil
  outdoor_interactives = {
    {
      -- roof options
      current = 1,
      options = {
        {
          -- nothing
          sprite_start = 192,
          sprite_height = 2,
          sprite_width = 6,
          x = 38,
          y = 26,
          carbon = {
            addition = 5384,
            multiplier = settings[2].value
          }
        },
        {
          -- solar panels
          sprite_start = 64,
          sprite_height = 2,
          sprite_width = 6,
          x = 38,
          y = 26,
          -- TODO: more realistic carbon value for how solar panels impact home energy usage
          carbon = {
            addition = 2500,
            multiplier = settings[2].value
          }
        },
      }
    },
    {
      -- door
      current = 1,
      options = {
        {
          sprite_start = 70,
          sprite_height = 4,
          sprite_width = 2,
          x = 80,
          y = 56
        }
      }
    },
    {
      -- car options
      current = 1,
      options = {
        {
          -- gas car
          sprite_start = 19,
          sprite_height = 3,
          sprite_width = 3,
          x = 36,
          y = 92,
          carbon = {
            addition = 11141,
            multiplier = settings[1].value
          }
        },
        {
          -- electric car
          sprite_start = 16,
          sprite_height = 3,
          sprite_width = 3,
          x = 36,
          y = 92,
          -- TODO: find more accurate electric car manufacturing carbon value
          carbon = {
            addition = 5000,
            multiplier = settings[1].value
          }
        },
        {
          -- bike
          sprite_start = 38,
          sprite_height = 2,
          sprite_width = 3,
          x = 36,
          y = 100,
          -- TODO: find more accurate bike manufacturing carbon value
          carbon = {
            addition = 10,
            multiplier = settings[1].value
          }
        }
      }
    },
    {
      -- trash options
      current = 1,
      options = {
        {
          -- trash
          sprite_start = 7,
          sprite_height = 2,
          sprite_width = 2,
          x = 72,
          y = 108,
          plastic = {
            multiplier = 1,
            addition = 0
          },
          carbon = {
            addition = 692,
            multiplier = settings[2].value
          }
        },
        {
          -- trash and recycling
          sprite_start = 7,
          sprite_height = 2,
          sprite_width = 4,
          x = 72,
          y = 108,
          plastic = {
            -- 8.4% recycling rate in 2017, 8.5% in 2018
            multiplier = 0.9,
            addition = 0
          },
          carbon = {
            addition = 401,
            multiplier = settings[2].value
          }
        }
      }
    }
  }

  kitchen_interactives = {
    {
      -- door
      current = 1,
      options = {
        {
          sprite_start = 70,
          sprite_height = 4,
          sprite_width = 2,
          x = 102,
          y = 32,
          multiplier = 1.5,
          flip_x = true
        }
      }
    },
    {
      -- groceries
      current = 1,
      options = {
        {
          -- plastic
          sprite_start = 132,
          sprite_height = 2,
          sprite_width = 2,
          x = 70,
          y = 82,
          multiplier = 1.5
        },
        {
          -- paper
          sprite_start = 134,
          sprite_height = 2,
          sprite_width = 2,
          x = 70,
          y = 82,
          multiplier = 1.5
        },
        {
          -- reusable
          sprite_start = 136,
          sprite_height = 2,
          sprite_width = 2,
          x = 70,
          y = 82,
          multiplier = 1.5
        },
      }
    },
    {
      -- range
      current = 1,
      options = {
        {
          -- gas range
          sprite_start = 90,
          sprite_height = 3,
          sprite_width = 2,
          x = 66,
          y = 44,
          multiplier = 1.5
        },
        {
          -- electric range
          sprite_start = 92,
          sprite_height = 3,
          sprite_width = 2,
          x = 66,
          y = 44,
          multiplier = 1.5
        }
      }
    },
    {
      -- fridge
      current = 1,
      options = {
        {
          sprite_start = 72,
          sprite_height = 4,
          sprite_width = 2,
          x = 28,
          y = 32,
          multiplier = 1.5
        }
      }
    },
    {
      -- door
      current = 1,
      options = {
        {
          sprite_start = 70,
          sprite_height = 4,
          sprite_width = 2,
          x = 2,
          y = 32,
          multiplier = 1.5,
          flip_x = true
        }
      }
    },
  }

  refrigerator_interactives = {
    {
      -- meat
      current = 1,
      options = {
        {
          -- beef
          sprite_start = 96,
          sprite_width = 2,
          sprite_height = 2,
          x = 20,
          y = 20,
          multiplier = 1.5,
          carbon = {
            -- 59.6 kg CO2 per kg beef
            -- average American consumes 25.8kg beef per year
            addition = 59.6 * 25.8,
            multiplier = settings[2].value
          }
        },
        {
          -- beyond
          sprite_start = 11,
          sprite_width = 2,
          sprite_height = 1,
          x = 20,
          y = 20,
          multiplier = 2,
          carbon = {
            addition = 6 * 25.8,
            multiplier = settings[2].value
          }
        }
      }
    },
    {
      -- handle for exit
      current = 1,
      options = {
        {
          sprite_start = 42,
          sprite_height = 2,
          sprite_width = 1,
          x = 0,
          y = 40,
          multiplier = 2
        }
      }
    },
    {
      -- milk
      current = 1,
      options = {
        {
          -- cow milk
          sprite_start = 110,
          sprite_width = 2,
          sprite_height = 2,
          x = 60,
          y = 12,
          multiplier = 2,
          carbon = {
            -- kg CO2 per kg milk
            -- average American consumes 66.1 kg milk per year
            addition = 2.8 * 66.1,
            multiplier = settings[2].value
          },
          plastic = {
            -- less than 60 grams per milk jug
            -- 66.1 kg is equivalent of 18 gallons milk per year
            addition = 0.060 * 18,
            multiplier = settings[2].value
          }
          -- also plastic value?
        },
        {
          -- soy milk
          sprite_start = 98,
          sprite_width = 2,
          sprite_height = 2,
          x = 60,
          y = 12,
          multiplier = 2,
          carbon = {
            -- kg CO2 per kg milk, needs convert to liquid
            addition = 1 * 66.1,
            multiplier = settings[2].value
          }
          -- plastic value?
        }
      }
    },
    {
      -- more meat
      current = 1,
      options = {
        {
          -- poultry
          sprite_start = 41,
          sprite_width = 1,
          sprite_height = 1,
          x = 20,
          y = 50,
          multiplier = 2.5,
          carbon = {
            -- 6.1 kg CO2 per kg poultry
            -- average American consumes 48.8kg chicken per year
            addition = 6.1 * 48.8,
            multiplier = settings[2].value
          }
        }
      }
    }
  }

  bathroom_interactives = {
    {
      -- door
      current = 1,
      options = {
        {
          sprite_start = 70,
          sprite_height = 4,
          sprite_width = 2,
          x = 2,
          y = 32,
          multiplier = 1.5
        }
      }
    },
  }

  bathroom_static = {
    {
      -- toilet
      current = 1,
      options = {
        {
          sprite_start = 108,
          sprite_height = 2,
          sprite_width = 2,
          x = 80,
          y = 56,
          multiplier = 2
        }
      }
    },
    {
      -- toilet paper
      current = 1,
      options = {
        {
          sprite_start = 30,
          sprite_height = 1,
          sprite_width = 1,
          x = 108,
          y = 60,
          multiplier = 1.5
        }
      }
    },
    {
      -- toilet paper holder
      current = 1,
      options = {
        {
          sprite_start = 76,
          sprite_height = 2,
          sprite_width = 1,
          x = 108,
          y = 56,
          multiplier = 2
        }
      }
    },
  }

  kitchen_static = {
    {
      -- table
      current = 1,
      options = {{
        sprite_start = 144,
        sprite_height = 3,
        sprite_width = 4,
        x = 60,
        y = 90,
        multiplier = 2
      }}
    }
  }

  -- link the scene transition items
  outdoor_interactives[2]['navigate'] = kitchen_interactives
  kitchen_interactives[1]['navigate'] = outdoor_interactives
  kitchen_interactives[3]['navigate'] = refrigerator_interactives
  kitchen_interactives[4]['navigate'] = bathroom_interactives
  refrigerator_interactives[2]['navigate'] = kitchen_interactives
  bathroom_interactives[1]['navigate'] = kitchen_interactives

  -- current state of game
  current_scene = outdoor_interactives
  current_index = 1
  current_item = current_scene[current_index]
end

alternative_selected = 0
setting_selected = 1

-- logic in update function avoids frame drops and weird button behaviors
function _update60()
  t = time()
  if (not show_instructions and not show_settings)
  then
    if (current_scene == outdoor_interactives)
    then
      updateOutside()
    elseif (current_scene == kitchen_interactives)
    then
      updateKitchen()
    elseif (current_scene == bathroom_interactives)
    then
      updateBathroom()
    elseif (current_scene == refrigerator_interactives)
    then
      updateRefrigerator()
    end

    -- logic for navigating around the items in the scene
    if (not show_alternatives and (btnp(buttons.down) or btnp(buttons.left)))
    then
      current_index = current_index % #current_scene + 1
      current_item = current_scene[current_index]
    elseif (not show_alternatives and (btnp(buttons.up) or btnp(buttons.right)))
    then
      current_index = (current_index - 2) % #current_scene + 1
      current_item = current_scene[current_index]
    end

    -- logic for opening and closing alternative selection
    if (not show_alternatives and btnp(buttons.o))
    then
      if (#current_item.options > 1)
      then
        alternative_selected = current_item.current - 1
        show_alternatives = true
        return
      elseif (current_item.navigate != nil)
      then
        current_scene = current_item.navigate
        current_index = 1
        current_item = current_scene[current_index]
      end
    elseif (show_alternatives and btnp(buttons.x))
    then
      show_alternatives = false
      return
    end

    -- logic for alternative selection
    if (show_alternatives)
    then
      -- highlight logic
      if (btnp(buttons.down))
      then
        alternative_selected = (alternative_selected + 1) % #current_item.options
      elseif (btnp(buttons.up))
      then
        alternative_selected = (alternative_selected - 1) % #current_item.options
      end

      -- selection logic
      if (btnp(buttons.o))
      then
        -- set current selection to be displayed in scene and close alternative selection
        show_alternatives = false
        current_item.current = alternative_selected + 1
      end
    end
  end
end

function _draw()
  cls()
  if (show_instructions)
  then
    drawInstructions()
  elseif (show_settings)
  then
    drawSettings()
  elseif (current_scene == outdoor_interactives)
  then
    drawOutside()
  elseif (current_scene == kitchen_interactives)
  then
    drawKitchen()
  elseif (current_scene == bathroom_interactives)
  then
    drawBathroom()
  elseif (current_scene == refrigerator_interactives)
  then
    drawRefrigerator()
  end

  -- flash highlight on and off
  if (not show_instructions and t % 2 < 1 and not show_alternatives and not show_settings)
  then
    color(14)
    local item = current_item.options[current_item.current]
    local highlight_x = item.x - 1
    local highlight_y = item.y - 1
    local width = item.sprite_width * 8
    local height = item.sprite_height * 8
    if (item.multiplier != nil)
    then
      width = width * item.multiplier
      height = height * item.multiplier
    end
    width = width + 1
    height = height + 1
    rect(highlight_x, highlight_y, highlight_x + width, highlight_y + height)
  end

  if (show_alternatives)
  then
    -- show alternative selection for current item
    drawAlternativeSelection(current_item)
  end

  if (not show_instructions and not show_settings)
  then
    drawHeadsUpDisplay()
  end
end

function drawHeadsUpDisplay()
  local co2 = 0
  local co2X1000 = 0
  local plasticBase = 0
  local plasticMultiplier = 1
  local lists = {outdoor_interactives, kitchen_interactives, bathroom_interactives, refrigerator_interactives}
  for i = 1, 4
  do
    local list = lists[i]
    for idx, val in ipairs(list)
    do
      local carbonVals = val.options[val.current].carbon
      local plasticVals = val.options[val.current].plastic
      if (carbonVals != nil)
      then
        local carbonAdd = carbonVals.addition
        local carbonMult = carbonVals.multiplier
        if (carbonMult != nil)
        then
          carbonMult = 1
        end
        if (carbonAdd != nil)
        then
          for i = 1, carbonMult
          do
            co2 += carbonAdd
            if (co2 > 1000)
            then
              local thousands = flr(co2 / 1000)
              local underThousand = co2 - (1000 * thousands)
              co2X1000 += thousands
              co2 = underThousand
            end
          end
        end
      end
      if (plasticVals != nil)
      then
        local plasticAdd = plasticVals.addition
        local plasticMult = plasticVals.multiplier
        if (plasticAdd != nil)
        then
          plasticBase += plasticAdd
        end
        if (plasticMult != nil)
        then
          plasticMultiplier = plasticMultiplier * plasticMult
        end
      end
    end
  end

  local co2units = flr(co2)
  if (co2units < 100)
  then
    co2units = '0'..co2units
  end
  color(7)
  rectfill(0, 0, 52, 16)
  color(0)
  print('plastic '..flr(plasticBase * plasticMultiplier), 2, 2)
  print('co2 '..co2X1000..','..co2units, 2, 10)
end

function drawInstructions()
  color(6)
  rectfill(8, 8, 120, 120)
  color(0)
  print('your goal is to reduce your', 12, 12)
  print('carbon and plastic output', 12, 20)
  print('as much as possible. use', 12, 28)
  print('the arrow keys to navigate', 12, 36)
  print('around to find items that', 12, 44)
  print('might have better', 12, 52)
  print('alternatives.', 12, 60)
  print('press z to select', 12, 76)
  print('press x to cancel', 12, 84)
  print('press z to change settings', hcenter('press z to change settings'), 102)
  print('press x to start', hcenter('press x to start'), 110)
  if (btnp(buttons.x))
  then
    setDefaultData()
    show_instructions = false
    _draw()
  elseif (btnp(buttons.o))
  then
    show_instructions = false
    show_settings = true
    _draw()
  end
end

function drawSettings()
  color(6)
  rectfill(8, 8, 120, 120)
  local height = 12
  for key, value in ipairs(settings)
  do
    color(0)
    if (key == setting_selected)
    then
      color(14)
      if (value.value > value.minimum)
      then
        print('-', 100, height)
      end
      print('+', 116, height)
    end
    print(value.label, 12, height)
    print(value.value, 108, height)
    height = height + 10
  end
  color(0)
  print('press x to start', hcenter('press x to start'), 110)

  if (btnp(buttons.x))
  then
    setDefaultData()
    show_settings = false
    _draw()
  elseif (btnp(buttons.left))
  then
    if (settings[setting_selected].value > settings[setting_selected].minimum)
    then
      settings[setting_selected].value = settings[setting_selected].value - 1
    end
  elseif (btnp(buttons.right))
  then
    settings[setting_selected].value = settings[setting_selected].value + 1
  elseif (btnp(buttons.up))
  then
    if (setting_selected > 1)
    then
      setting_selected = setting_selected - 1
    end
  elseif (btnp(buttons.down))
  then
    if (setting_selected < #settings)
    then
      setting_selected = setting_selected + 1
    end
  end
end

function drawOutside()
  map(0, 0, 0, 0, 16, 16)
  for key, value in ipairs(outdoor_interactives)
  do
    drawSprite(value.options[value.current])
  end
end

function drawKitchen()
  map(16, 0, 0, 0, 16, 16)
  for key, value in ipairs(kitchen_static)
  do
    drawSprite(value.options[value.current])
  end
  for key, value in ipairs(kitchen_interactives)
  do
    drawSprite(value.options[value.current])
  end
end

function drawBathroom()
  map(32, 0, 0, 0, 16, 16)
  for key, value in ipairs(bathroom_interactives)
  do
    drawSprite(value.options[value.current])
  end
  for key, value in ipairs(bathroom_static)
  do
    drawSprite(value.options[value.current])
  end
end

function drawRefrigerator()
  map(48, 0, 0, 0, 16, 16)
  for key, value in ipairs(refrigerator_interactives)
  do
    drawSprite(value.options[value.current])
  end
end

function drawSprite(item)
  -- https://pico-8.fandom.com/wiki/Sspr
  -- sspr( sx, sy, sw, sh, dx, dy, [dw,] [dh,] [flip_x,] [flip_y] )
  -- sx: The x coordinate of the upper left corner of the rectangle in the sprite sheet.
  -- sy: The y coordinate of the upper left corner of the rectangle in the sprite sheet.
  -- sw: The width of the rectangle in the sprite sheet, as a number of pixels.
  -- sh: The height of the rectangle in the sprite sheet, as a number of pixels.
  -- dx: The x coordinate of the upper left corner of the rectangle area of the screen.
  -- dy: The y coordinate of the upper left corner of the rectangle area of the screen.
  -- dw: The width of the rectangle area of the screen. The default is to match the image width (sw).
  -- dh: The height of the rectangle area of the screen. The default is to match the image height (sh).
  local sx = (item.sprite_start % 16) * 8
  local sy = (item.sprite_start \ 16) * 8
  local sw = item.sprite_width * 8
  local sh = item.sprite_height * 8
  local dw = sw
  local dh = sh
  if (item.multiplier != nil)
  then
    dw = dw * item.multiplier
    dh = dh * item.multiplier
  end
  sspr(sx, sy, sw, sh, item.x, item.y, dw, dh, item.flip_x)
end

function updateOutside()
  _draw()
end

function updateKitchen()
  _draw()
end

function updateBathroom()
  _draw()
end

function updateRefrigerator()
  _draw()
end

function drawAlternativeSelection(item)
  -- alternative options
  color(0)
  for idx, val in ipairs(item.options)
  do
    rectfill(8, 8 + ((idx - 1) * 40), 120, 40 * idx)
    -- TODO: ideally, center the sprite in the rect
    spr(val.sprite_start, 50, 40 * (idx - 0.5), val.sprite_width, val.sprite_height)
  end

  -- draw highlight rectangle around current selection
  color(14)
  rect(8, 8 + alternative_selected * 40, 120, 40 + alternative_selected * 40)
end

__gfx__
0000000033b33333cccccccc0005000566666666dddddddd6666666000000000000000000000000000000000000000000000000000000000aaa9aaaa66666666
00000000333333b3cccccccc0005000564444444dddddddd6466666600000000000000000000000000000000444022808422288000000000aa999aaa67777777
0000000033333333cccccccc0005000564444444ddddddddd660666f00666666666660000066666666666000404020888040280800000000a99999aa67777777
00000000b3333333cccccccc55555555644444445555555566666466066666666666666006666666666666604444220840402808000000009999999a67777777
00000000333b3333cccccccc5000500066666666dddddddd6f66666606666666666666600666666666666660400420084040280800000000a999999966666666
0000000033333333cccccccc5000500044464444dddddddd66676606001161116116110000bb6bbb6bb6bb00444422280420288000000000aa99999a77767777
0000000033333b33cccccccc5000500044464444dddddddd606666660001611161161000000b6bbb6bb6b000000000000000000000000000aaa999aa77767777
0000000033333333cccccccc5555555544464444dddddddd666d66760001161161161000000bb6bb6bb6b000000000000000000000000000aaaa9aaa77767777
000000000000000000000000000000000000000000000000000000000001161161161000000bb6bb6bb6b0001111111111111111111111110000000000000000
000000000000000000000000000000000000000000000000000000000001161161161000000bb6bb6bb6b0001cccccccccc6ccccccccccc10667777006677770
000000bbbbbbbbbbb00000000000008888888888000000000000000000001611616100000000b6bb6b6b00001cccccccccc6ccccccccccc16666777766667777
000000bbbbbbbbbbb00000000000008888888888000000000000000000001161616100000000bb6b6b6b00001cccccccccc6ccccccccccc16446777764467777
000000bbcccccccbb000000000000088ccccccc8000000000000000000001161616100000000bb6b6b6b00001cccccccccc6ccccccccccc16446777764467777
000000bbcccccccbb000000000000088ccccccc80000000000000000000001616160000000000b6b6b6000001cccccccccc6ccccccccccc16666777766667777
000000bbcccccccbb000000000000088ccccccc80000000000000000000001111110000000000bbbbbb000001cccccccccc6ccccccccccc10667777006677770
000000bbcccccccbb000000000000088ccccccc80000000000000000000000000000000000000000000000001cccccccccc6ccccccccccc10000000000000000
000000bbcc666ccbb000000000000088ccccccc88000000000000000000000000000000000000000000ddddd1cccccccccc6ccccccccccc10000000000000000
000000bbb666a6bbb0000000000000888886668880000000000000000000000000000000000ff00000dddddd1cccccccccc6ccccccccccc10667777000000000
000000bbb66a66bbb00000000000008888666668800000000000000000000100000000000ffffff00ddddddd1cccccccccc6ccccccccccc16666777700000000
000bbbbbb6aa66bbbbbb00000008888888666668888800000002200000000011000000000ffffff0dddddddd1666666666666666666666616446777700000000
000bbbbbbaaaaabbbbbb000000088888888666888888000000022220000000011100000007ffff70ddddd0001cccccccccc6ccccccccccc16446777700000000
000bb999b66aa6b999bb000000088aaa8888888aaa88000000002222211000010010000007ffff70dddd00001cccccccccc6ccccccccccc16666777700000000
000bb999b66a66b999bb000000088aaa8888668aaa880000000022210001111100000000070ff070ddd000001cccccccccc6ccccccccccc10667777000000000
000bb999b6a666b999bb000000088aaa8888668aaa88000000000100110000010000000000000000ddd000001cccccccccc6ccccccccccc10000000000000000
00555555555555555555500000555555555555555555500000000100001100001000000044404440ddd000001cccccccccc6ccccccccccc1eeefeeeeffff5fff
00555555555555555555500000555555555556655555500000051500000011051500000044404440ddd000001cccccccccc6ccccccccccc1eefffeeeffff5fff
000ddd00000000000ddd0000000ddd00000056650ddd000005501055000005111055000005550400ddd000001cccccccccc6ccccccccccc1efffffeeffff5fff
000ddd00000000000ddd0000000ddd00000055550ddd000005001005000005001005000055555400dddd00001cccccccccc6ccccccccccc1fffffffe55555555
000ddd00000000000ddd0000000ddd00000000000ddd000005000005000005000005000054505400ddddd0001cccccccccc6ccccccccccc1efffffffffff5fff
000000000000000000000000000000000000000000000000055000550000055000550000045004000ddddddd1cccccccccc6ccccccccccc1eefffffeffff5fff
0000000000000000000000000000000000000000000000000005550000000005550000000000000000dddddd1cccccccccc6ccccccccccc1eeefffeeffff5fff
00000000000000000000000000000000000000000000000000000000000000000000000000000000000ddddd111111111111111111111111eeeefeeeffff5fff
000000006666666666666666666666666666666600000000111111111111111100dddddddddddd00000000000000000000000000dd666666666666dd66666666
00000000611111166111111661111116611111160000000014444444444444410dddddddddddddd0000000000000000000000000dd666666666666dd66666666
0000000061111116611111166111111661111116000000001444444444444441dddddddddddddddd0000000000000000ddddddd0dd666666666666dd66666666
0000000061111116611111166111111661111116000000001444444444444441dddddddddddddddd0000000000000000d00000d0dd666666666666dd66666666
0000000061111116611111166111111661111116000000001444444444444441dddddddddddddddd0000000000000000d00000d0dd666666666666dd66666666
0000000061111116611111166111111661111116000000001444444444444441dddddddddddddddd0000000000000000dd0000d0dd666666666666dd66666666
0000000061111116611111166111111661111116000000001444444444444441dddddddddddddddd0000000000000000000000d0dd666666666666dd66666666
0000000066666666666666666666666666666666000000001444444444444441dddddddddddddddd0000000000000000000000d0dd666666666666dd66666666
6666666666666666666666666666666666666666666666661444444444444441dddddddddddddddddddddddddddddddd000000d0dddddddd6666666600000000
6111111661111116611111166111111661111116611111161444444444444441dddddddddddddddddddddddddddddddd000000d0dddddddd6666666600000000
6111111661111116611111166111111661111116611111161444444444444441dddddddddddddddd8d8d8dddddd8d8d8000000d0666666666666666600000000
6111111661111116611111166111111661111116611111161444444444444441dddddddddddddddd88888dddddd88888000000d0666666666666666600000000
6111111661111116611111166111111661111116611111161444444444444441dddddddddddddddd55555555555555550dddddd0666666666666666600000000
6111111661111116611111166111111661111116611111161444444444444441dddddddddddd66dd66d66dddddd66d66dddddddd666666666666666600000000
6111111661111116611111166111111661111116611111161444444444444441dddddddddddd66dd66d66dddddd66d660dddddd066666666dddddddd00000000
6666666666666666666666666666666666666666666666661444444444444441dddddddddddd66dd55555555555555550000000066666666dddddddd00000000
0000000000000000000000000000000000000000000000001444444444455441dddddddddddd66dddddddddddddddddd00777777777770000000000000000000
0000000000000000000000000000000000000000000000001444444444555541dddddddddddd66ddddd6666666666ddd00776677777770000000000000000000
0004477777744440000000000000000000000000000000001444444444555541dddddddddddd66dddddddddddddddddd00766677777770000000000000000000
0004447777444440000000ccc000000000000000000000001444444444455441dddddddddddddddddddddddddddddddd0077777777777000000000ccc0000000
0004444774444440000000777000000000000000000000001444444444444441dddddddddddddddddddd77777777dddd00007777777000000000007770000000
0004444474444400000077777777700000000000000000001444444444444441ddddddddddddddddddd7777777777ddd00006666666000000000777777777000
0004444474444400000077777700700000000000000000001444444444444441dddddddddddddddddd777777777777dd00067777777600000000777777007000
00004444744444000007777777007000000000000000000014444444444444415555555555555555dd777777777777dd00677777777760000007777777007000
0000044474444400000111711101710000000000000000001444444444444441ddddddddddddddddddd7777777777ddd00677777777760000007777777007000
0000000474444000000177717171710000000000000000001444444444444441dddddddddddddddddddd77777777dddd00667777777660000007777777777000
0000000474444000000111717171110000000000000000001444444444444441dddddddddddddddddddddddddddddddd00066666666600000007777777770000
0000000444440000000771717177100000000000000000001444444444444441dddddddddddddddd555555555555555500006666666000000007777777770000
0000000444400000000111711177100000000000000000001444444444444441ddddddddddddddddddd6666666666ddd00000777770000000000777777770000
0000000444400000000007777770000000000000000000001444444444444441dddddddddddddddddddddddddddddddd00000777770000000000077777700000
0000000444000000000000000000000000000000000000001444444444444441dddddddddddddddddddddddddddddddd00077777777700000000000000000000
00000000000000000000000000000000000000000000000014444444444444410dddddddddddddd0dddddddddddddddd00077777777700000000000000000000
00000000000000000000000000000000777000000077700000000000000000000000000000000000040404040404040404040404040404040404040404040404
04040404040404040404040404040404707000000070700000000044400000000000001110000000040000000000000000000000000000000000000000000000
00000000000000000000000000000000707000000070700000000400040000000000010001000000040404040404040404040404040404040404040404040404
04040404040404040404040404040404707000000070700000000400040000000000010001000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000707000777777700000044444444400000001111111110000040404040404040404040404040404040404040404040404
040404040404040404040404040404047777777777777000000444444444000000033bb311110000000000000000000000000000000000000000000000000000
000000000000000000000000000000007777777777777000000444444444000000033bb388810000040404040404040404040404040404040404040404040404
04040404040404040404040404040404777777777777700000044444444400000003333388810000000000000000000000000000000000000000000000000000
0000000000000000000000000000000077777777777770000004444444440000000333338bb10000040404040404040404040404040404040404040404040404
555555555555555555555555550000007777777777777000000444444444000000033bb31bb10000000000000000000000000000000000000000000000000000
555555555555555555555555555000007777777777777000000444444444000000018bb111110000040404040404040404040404040404040404040404040404
55555555555555555555555555550000777777777777700000044444444400000001888111110000000000000000000000000000000000000000000000000000
5555555555555555555555555555500077777777777770000004444444440000000188811bb10000040404040404040404040404040404040404040404040404
5555555555555555555555555555550007777777777770000004444444440000000111111bb10000000000000000000000000000000000000000000000000000
55555555555555555555555555555555007777777777000000044444444400000001111111110000040404040404040404040404040404040404040404040404
55055555555555555555555555555555000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55005555555555555555555555555555000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
55000555555555555555555555555555040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
55000550000000000000000055000055000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
55000550000000000000000055000055040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
55000550000000000000000055000055000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
55000550000000000000000055000055040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
00000550000000000000000000000055000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000550000000000000000000000055040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
00000550000000000000000000000055000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000550000000000000000000000055040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
00000550000000000000000000000055000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000550000000000000000000000055040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040400040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404
__label__
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cc000c0ccc000cc00c000c000cc00ccccc000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cc0c0c0ccc0c0c0cccc0ccc0cc0ccccccc0c0ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cc000c0ccc000c000cc0ccc0cc0ccccccc0c0ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cc0ccc0ccc0c0ccc0cc0ccc0cc0ccccccc0c0ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cc0ccc000c0c0c00ccc0cc000cc00ccccc000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc00050005cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc00050005cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccc00cc00c000ccccc00cc0ccc000ccccccccccccccccccccccccccc00050005cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cc0ccc0c0ccc0cccccc0cc0ccc0c0ccccccccccccccccccccccccccc55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cc0ccc0c0c000cccccc0cc000c0c0ccccccccccccccccccccccccccc50005000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cc0ccc0c0c0cccccccc0cc0c0c0c0ccccccccccccccccccccccccccc50005000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccc00c00cc000ccccc000c000c000ccccccccccccccccccccccccccc50005000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00050005000500050005000500050005cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00050005000500050005000500050005cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc00050005000500050005000500050005cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc55555555555555555555555555555555cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc50005000500050005000500050005000cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc50005000500050005000500050005000cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc50005000500050005000500050005000cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc55555555555555555555555555555555cccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc00050005000500050005000500050005000500050005000500050005cccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc00050005000500050005000500050005000500050005000500050005cccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc00050005000500050005000500050005000500050005000500050005cccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc55555555555555555555555555555555555555555555555555555555cccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc50005000500050005000500050005000500050005000500050005000cccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc50005000500050005000500050005000500050005000500050005000cccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc50005000500050005000500050005000500050005000500050005000cccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc55555555555555555555555555555555555555555555555555555555cccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccc00050005000500050005000500050005000500050005000500050005000500050005000500050005cccccccccccccccccccccccc
cccccccccccccccccccccccc00050005000500050005000500050005000500050005000500050005000500050005000500050005cccccccccccccccccccccccc
cccccccccccccccccccccccc00050005000500050005000500050005000500050005000500050005000500050005000500050005cccccccccccccccccccccccc
cccccccccccccccccccccccc55555555555555555555555555555555555555555555555555555555555555555555555555555555cccccccccccccccccccccccc
cccccccccccccccccccccccc50005000500050005000500050005000500050005000500050005000500050005000500050005000cccccccccccccccccccccccc
cccccccccccccccccccccccc50005000500050005000500050005000500050005000500050005000500050005000500050005000cccccccccccccccccccccccc
cccccccccccccccccccccccc50005000500050005000500050005000500050005000500050005000500050005000500050005000cccccccccccccccccccccccc
cccccccccccccccccccccccc55555555555555555555555555555555555555555555555555555555555555555555555555555555cccccccccccccccccccccccc
cccccccccccccccc000500050005000500050005000500050005000500050005000500050005000500050005000500050005000500050005cccccccccccccccc
cccccccccccccccc000500050005000500050005000500050005000500050005000500050005000500050005000500050005000500050005cccccccccccccccc
cccccccccccccccc000500050005000500050005000500050005000500050005000500050005000500050005000500050005000500050005cccccccccccccccc
cccccccccccccccc555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555cccccccccccccccc
cccccccccccccccc500050005000500050005000500050005000500050005000500050005000500050005000500050005000500050005000cccccccccccccccc
cccccccccccccccc500050005000500050005000500050005000500050005000500050005000500050005000500050005000500050005000cccccccccccccccc
cccccccccccccccc500050005000500050005000500050005000500050005000500050005000500050005000500050005000500050005000cccccccccccccccc
cccccccccccccccc555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555cccccccccccccccc
cccccccccccccccccccccccc66666666666666666666666666666666666666666666666666666666666666666666666666666666cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444644444446444444464444444644444446444444464444444644444446444444464444444cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444644444446444444464444444644444446444444464444444644444446444444464444444cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444644444446444444464444444644444446444444464444444644444446444444464444444cccccccccccccccccccccccc
cccccccccccccccccccccccc66666666666666666666666666666666666666666666666666666666666666666666666666666666cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444444644444446444444464444444644444446444444464444444644444446444444464444cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444444644444446444444464444444644444446444444464444444644444446444444464444cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444444644444446444444464444444644444446444444464444444644444446444444464444cccccccccccccccccccccccc
cccccccccccccccccccccccc66666666dddddddddddddddddddddddddddddddd6666666666666666111111111111111166666666cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444dddddddddddddddddddddddddddddddd6444444464444444144444444444444164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444dddddddddddddddddddddddddddddddd6444444464444444144444444444444164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444555555555555555555555555555555556444444464444444144444444444444164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc66666666dddddddddddddddddddddddddddddddd6666666666666666144444444444444166666666cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc66666666dddddddddddddddddddddddddddddddd6666666666666666144444444444444166666666cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444dddddddddddddddddddddddddddddddd6444444464444444144444444444444164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444dddddddddddddddddddddddddddddddd6444444464444444144444444444444164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444555555555555555555555555555555556444444464444444144444444444444164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc66666666dddddddddddddddddddddddddddddddd6666666666666666144444444444444166666666cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc66666666dddddddddddddddddddddddddddddddd6666666666666666144444444445544166666666cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444dddddddddddddddddddddddddddddddd6444444464444444144444444455554164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444dddddddddddddddddddddddddddddddd6444444464444444144444444455554164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444555555555555555555555555555555556444444464444444144444444445544164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc66666666dddddddddddddddddddddddddddddddd6666666666666666144444444444444166666666cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc66666666dddddddddddddddddddddddddddddddd6666666666666666144444444444444166666666cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444dddddddddddddddddddddddddddddddd6444444464444444144444444444444164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444dddddddddddddddddddddddddddddddd6444444464444444144444444444444164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc64444444555555555555555555555555555555556444444464444444144444444444444164444444cccccccccccccccccccccccc
cccccccccccccccccccccccc66666666dddddddddddddddddddddddddddddddd6666666666666666144444444444444166666666cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
cccccccccccccccccccccccc44464444dddddddddddddddddddddddddddddddd4446444444464444144444444444444144464444cccccccccccccccccccccccc
33b3333333b3333333b3333333b333336666666066666660666666606666666033b3333333b3333333b3333333b3333333b3333333b3333333b3333333b33333
333333b3333333b3333333b3333333b364666666646666666466666664666666333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3
33333333333333333333333333333333d660666fd660666fd660666fd660666f3333333333333333333333333333333333333333333333333333333333333333
b3333333b3333333b3333333b333333366666466666664666666646666666466b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333
333b3333333b3333333b3333333b33336f6666666f6666666f6666666f666666333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333
33333333333333333333333333333333666766066667660666676606666766063333333333333333333333333333333333333333333333333333333333333333
33333b3333333b3333333b3333333b336066666660888888888866666066666633333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b33
33333333333333333333333333333333666d66766688888888886676666d66763333333333333333333333333333333333333333333333333333333333333333
33b3333333b3333333b3333333b33333666666606688ccccccc866606666666033b3333333b3333333b3333333b3333333b3333333b3333333b3333333b33333
333333b3333333b3333333b3333333b3646666666488ccccccc8666664666666333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3
33333333333333333333333333333333d660666fd688ccccccc8666fd660666f3333333333333333333333333333333333333333333333333333333333333333
b3333333b3333333b3333333b3333333666664666688ccccccc8646666666466b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333
333b3333333b3333333b3333333b33336f6666666f88ccccccc886666f666666333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333
33333333333333333333333333333333666766066688888666888606666766063333333333333333333333333333333333333333333333333333333333333333
33333b3333333b3333333b3333333b336066666660888866666886666066666633333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b33
33333333333333333333333333333333666d66788888886666688888666d66763333333333333333333333333333333333333333333333333333333333333333
33b3333333b3333333b3333333b333336666666888888886668888886666666033b3333333b3333333b3333333b3333333b3333333b3333333b3333333b33333
333333b3333333b3333333b3333333b3646666688aaa8888888aaa8864666666333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3
33333333333333333333333333333333d66066688aaa8888668aaa88d660666f3333333333333333333333333333333333333333333333333333333333333333
b3333333b3333333b3333333b3333333666664688aaa8888668aaa8866666466b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333
333b3333333b3333333b3333333b33336f66665555555555555555555f666666333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333
33333333333333333333333333333333666766555555555556655555566766063333333333333333333333333333333333333333333333333333333333333333
33333b3333333b3333333b3333333b336066666ddd66666656656ddd6066666633333b333366666666666b3333333b3333333b3333333b3333333b3333333b33
33333333333333333333333333333333666d667ddd6d667655556ddd666d66763333333336666666666666633333333333333333333333333333333333333333
33b3333333b3333333b3333333b333336666666ddd66666066666ddd6666666033b33333366666666666666333b3333333b3333333b3333333b3333333b33333
333333b3333333b3333333b3333333b364666666646666666466666664666666333333b333116111611611b3333333b3333333b3333333b3333333b3333333b3
33333333333333333333333333333333d660666fd660666fd660666fd660666f3333333333316111611613333333333333333333333333333333333333333333
b3333333b3333333b3333333b333333366666466666664666666646666666466b3333333b331161161161333b3333333b3333333b3333333b3333333b3333333
333b3333333b3333333b3333333b33336f6666666f6666666f6666666f666666333b33333331161161161333333b3333333b3333333b3333333b3333333b3333
33333333333333333333333333333333666766066667660666676606666766063333333333311611611613333333333333333333333333333333333333333333
33333b3333333b3333333b3333333b336066666660666666606666666066666633333b333333161161613b3333333b3333333b3333333b3333333b3333333b33
33333333333333333333333333333333666d6676666d6676666d6676666d66763333333333331161616133333333333333333333333333333333333333333333
33b3333333b3333333b3333333b333336666666066666660666666606666666033b3333333b311616161333333b3333333b3333333b3333333b3333333b33333
333333b3333333b3333333b3333333b364666666646666666466666664666666333333b333333161616333b3333333b3333333b3333333b3333333b3333333b3
33333333333333333333333333333333d660666fd660666fd660666fd660666f3333333333333111111333333333333333333333333333333333333333333333
b3333333b3333333b3333333b333333366666466666664666666646666666466b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333333
333b3333333b3333333b3333333b33336f6666666f6666666f6666666f666666333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b3333
33333333333333333333333333333333666766066667660666676606666766063333333333333333333333333333333333333333333333333333333333333333
33333b3333333b3333333b3333333b336066666660666666606666666066666633333b3333333b3333333b3333333b3333333b3333333b3333333b3333333b33
33333333333333333333333333333333666d6676666d6676666d6676666d66763333333333333333333333333333333333333333333333333333333333333333

__map__
020202020202020202020202020202020f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000001010101010101010101010101010101060606060606060606060606060606060505050505050505050505050505050504040404040404040404040404040404
020202020202020302020202020202020f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f00005d5d5d5d5d5d5d5d5d5d5d5d000001010101010101010101010101010101060606060606060606060606060606060505050505050505050505050505050504040404040404040404040404040404
020202020202030303030202020202020f0f0f0f0f0f0f0f1b1c1d0f0f0f0f0f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f00004d4f4f4f4f4f4f4f4f4f4f4e000001010101010101010101010101010101060606060606060606060606060606060505050505050505050505050505050504040404040404040404040404040404
020202020303030303030302020202020f0f0f0f0f0f0f0f2b2c2d0f0f0f0f0f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f00004d4f4f4f4f4f4f4f4f4f4f4e000001010101010101010101010101010101060606060606060606060606060606060505050505050505050505050505050504040404040404040404040404040404
020202030303030303030303030202020f0f0f0f0f0f0f0f3b3c3d0f0f0f0f0f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f00004d4f4f4f4f4f4f4f4f4f4f4e000001010101010101010101010101010101060606060606060606060606060606060505050505050505050505050505050504040404040404040404040404040404
020203030303030303030303030302020f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f00005e5e5e5e5e5e5e5e5e5e5e5e000001010101010101010101010101010101060606060606060606060606060606060505050505050505050505050505050504040404040404040404040404040404
020202040404040404040404040202020f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f00004d4f4f4f4f4f4f4f4f4f4f4e000001010101010101010101010101010101060606060606060606060606060606060505050505050505050505050505050504040404040404040404040404040404
020202040505050504040404040202020f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f00004d4f4f4f4f4f4f4f4f4f4f4e000001010101010101010101010101010101060606060606060606060606060606060505050505050505050505050505050504040404040404040404040404040404
020202040505050504040404040202020f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f40404d4f4f4f4f4f4f4f4f4f4f4e404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
020202040505050504040404040202020f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f40405e5e5e5e5e5e5e5e5e5e5e5e404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
020202040505050504040404040202020e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e40404d4f4f4f4f4f4f4f4f4f4f4e404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
010101010606060601010101010101010e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e40404d4f4f4f4f4f4f4f4f4f4f4e404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
010101010606060601010101010101010e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e40404d4f4f4f4f4f4f4f4f4f4f4e404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
010101010606060601010101010101010e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e40404d4f4f4f4f4f4f4f4f4f4f4e404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
010101010606060601010101010101010e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e40405e5e5e5e5e5e5e5e5e5e5e5e404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
010101010606060601010101010101010e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000
