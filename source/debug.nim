import natu/[video, input, math, maxmod, utils, mgba]
import data/[variables, anim_index]
import oamdraw, save



# proc RandomState*()=
#     random = rand(1, 100)
#     seed(uint32(random + pet.cf * 4 ))
#     printf(logDebug, "Seed: %d", random)
#     if random >= 50:
#         case petstate
#         of walking:
#             petstate = idle
#             setAnim(pet, petIdle)
#         else:
#             petstate = walking
#             case curdirection
#             of up:
#                 setAnim(pet, petWalk2)
#                 objMem[1].hflip = false
#             of down:
#                 setAnim(pet, petWalk1)
#                 objMem[1].hflip = false
#             of left:
#                 setAnim(pet, petWalk1)
#                 objMem[1].hflip = true
#             of right:
#                 setAnim(pet, petWalk2)
#                 objMem[1].hflip = true
#     gametick = 0

# proc CheckClick()=
#     if (not(click.hitbox.set1.x > pet.hitbox.set2.x or click.hitbox.set2.x < pet.hitbox.set1.x or click.hitbox.set1.y > pet.hitbox.set2.y or click.hitbox.set2.y < pet.hitbox.set1.y)):
#         maxmod.effect(sfxPop)
#     else:
#         for i in 2..4:
#             if (not(click.hitbox.set1.x > offsets[i].set2.x or click.hitbox.set2.x < offsets[i].set1.x or click.hitbox.set1.y > offsets[i].set2.y or click.hitbox.set2.y < offsets[i].set1.y)):
#                 maxmod.effect(sfxPop)
#                 break
#         discard
        

# proc MovePet*()=
#     gametick = gametick + 1
#     if gametick >= 360:
#         RandomState()
#     keyPoll()
#     if keyIsDown(kiUp):
#         click.coor.y = click.coor.y - fp(1)
#     if keyIsDown(kiDown):
#         click.coor.y = click.coor.y + fp(1)
#     if keyIsDown(kiLeft):
#         click.coor.x = click.coor.x - fp(1)
#     if keyIsDown(kiRight):
#         click.coor.x = click.coor.x + fp(1)
#     if keyHit(kiA):
#         CheckClick()
#     if keyHit(kiStart): 
#         writeSave()
#         printf(logDebug, "Wrote save.")
#     if keyHit(kiSelect): 
#         readSave()
#         printf(logDebug, "Read save.")

#     if petstate == walking: 
#         if (pet.cf == 1 or pet.cf == 3):
#             case curdirection
#                 of up:
#                     pet.coor.y = pet.coor.y - fp(0.1)
#                     pet.coor.x = pet.coor.x - fp(0.2)
#                     if pet.coor.x <= fp(128):
#                         curdirection = left
#                         setAnim(pet, petWalk1)
#                         objMem[1].hflip = true
#                 of down:
#                     pet.coor.y = pet.coor.y + fp(0.1)
#                     pet.coor.x = pet.coor.x + fp(0.2)
#                     if pet.coor.x >= fp(164):
#                         curdirection = right
#                         setAnim(pet, petWalk2)
#                         objMem[1].hflip = true
#                 of left:
#                     pet.coor.y = pet.coor.y + fp(0.1)
#                     pet.coor.x = pet.coor.x - fp(0.2)
#                     if pet.coor.x <= fp(74):
#                         curdirection = down
#                         setAnim(pet, petWalk1)
#                         objMem[1].hflip = false
#                 of right:
#                     pet.coor.y = pet.coor.y - fp(0.1)
#                     pet.coor.x = pet.coor.x + fp(0.2)
#                     if pet.coor.x >= fp(218):
#                         curdirection = up
#                         setAnim(pet, petWalk2)
#                         objMem[1].hflip = false
    
#     for a in actors:
#         posInt = vec2i(a.coor)
#         objMem[a.oam].pos = posInt
#         a.hitbox.set1 = a.coor + offsets[a.oam].set1
#         a.hitbox.set2 = a.coor + offsets[a.oam].set2

# proc miscdebug*()=
#     if keyIsDown(kiUp):
#         camTarget.y += 1
#     if keyIsDown(kiDown):
#         camTarget.y -= 1
#     if keyIsDown(kiLeft) and petpos.x != 0:
#         petpos.x = petpos.x - fp(0.4)
#     if keyIsDown(kiRight) and petpos.x != 110:
#         petpos.x = petpos.x + fp(0.4)
#     if keyHit(kiA):
#         maxmod.effect(sound)
#     if keyHit(kiB):
#         maxmod.cancelAllEffects()
#         case sound:
#         of sfxChew:
#             sound = sfxYawn
#         of sfxYawn:
#             sound = sfxChirp
#         of sfxChirp:
#             sound = sfxGiggle
#         of sfxGiggle:
#             sound = sfxPop
#         of sfxPop:
#             sound = sfxTummy
#         of sfxTummy:
#             sound = sfxChew
#     if keyIsDown(kiL) and volume > fp(0.0):
#         volume = volume - fp(0.1)
#         maxmod.setEffectsVolume(volume)
#     if keyIsDown(kiR) and volume < fp(1.0):
#         volume = volume + fp(0.1)
#         maxmod.setEffectsVolume(volume)