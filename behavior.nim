import natu/[utils, mgba, math]
import variables

proc processBehavior()=
    case petstate
    of walkleft:
        petpos.x = petpos.x - fp(0.4)
        steps -= 1
        if steps == 0:
            petstate = idle
            printf(logDebug, "Idling.")
    of walkright:
        petpos.x = petpos.x + fp(0.4)
        steps -= 1
        if steps == 0:
            petstate = idle
            printf(logDebug, "Idling.")
    of idle:
        discard

    posInt = vec2i(petpos)



proc UpdatePet*()= 
    if petstate == idle:
      random = rand(1, 10000)
      if random <= 20:
        steps = 20
        random = rand(1, 100)
        if random <= 50:
          petstate = walkleft
          printf(logDebug, "Walking left.")
        else:
          petstate = walkright
          printf(logDebug, "Walking right.")

    processBehavior()







