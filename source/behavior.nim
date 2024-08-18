import natu/[video, utils, math, maxmod]
import data/[variables, anim_index]
import oamdraw

proc IsHappy*()=
  case joy
  of true:
    if petstate == idle:
      SetAnim(pet, petIdle)
    elif petstate == blink:
      SetAnim(pet, petBlink)
  of false:
    if petstate == idle:
      SetAnim(pet, petSad)
    elif petstate == blink:
      SetAnim(pet, petBlinkSad)
  

proc processBehavior()=
    case petstate
    of walkleft:
        pet.coor.x = pet.coor.x - fp(0.4)
        steps -= 1
        if steps == 0:
            petstate = idle
            IsHappy()
    of walkright:
        pet.coor.x = pet.coor.x + fp(0.4)
        steps -= 1
        if steps == 0:
            petstate = idle
            objMem[0].hflip = false
            IsHappy()
    of eat:
      if iterations >= 2:
        if hunger < 100:
          hunger = hunger - 15
        petstate = laugh
        SetAnim(pet, petHappy)
        maxmod.effect(sfxGiggle)

    of bath:
      if iterations >= 2:
        petstate = laugh
        SetAnim(pet, petHappy)
        maxmod.effect(sfxGiggle)

    of laugh:
      if iterations >= 2:
        petstate = idle
        IsHappy()
    
    of blink:
      if iterations >= 1:
        petstate = idle
        IsHappy()
    of hungry:
      if iterations >= 2:
        petstate = idle
        IsHappy()

    else:
        discard

    # posInt = vec2i(pet.coor)


proc UpdatePet*()=
    if petstate == idle and iterations >= 220:
      random = rand(1, 10000)
      case random:
      of 0..20:
        steps = 75
        random = rand(1, 100)
        if random <= 50 and pet.coor.x > 44:
          petstate = walkleft
          SetAnim(pet, petWalk)
        elif pet.coor.x < 164:
          petstate = walkright
          SetAnim(pet, petWalk)
          objMem[0].hflip = true
      of 300..305:
        if hunger >= 45:
          petstate = hungry
          maxmod.effect(sfxTummy)
          SetAnim(pet, petIck)
        else:
          petstate = blink
          IsHappy()
      else:
        discard

    processBehavior()







