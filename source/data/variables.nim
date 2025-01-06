import natu/[math, video, graphics, maxmod]
import anim_index
# import natu/[graphics]

# type Gametypes* = enum 
#     title = 0
#     raisepet
#     minigame
#     credits

type behaviorState* = enum # pet state
    idle = 0
    walking
    blink
    hungry
    eat
    bath
    laugh


# type SelectPos* = enum # position of menu cursor
#     left = 0
#     middle
#     right
type Collider* = object
    set1*: Vec2f
    set2*: Vec2f

type Actor* = ref object
    graphic*: Graphic
    coor*: Vec2f
    ca*: ID
    cf*: int
    anitimer*: int
    oam*: int
    hitbox*: Collider

# type Dirtrange* = enum
#     clean
#     dusty
#     dirty
#     pigsty



# type BalloonAttributes* = object
#     iter*: uint8
#     dirRight*: bool
#     act*: uint8
#     col*: Collider

type MusicControl* = enum
    play
    fadeup
    fadedown
    silent

var musicstate* = play
# var menuup* = false
# var hunger*: int
# var dirt*: int
# var fun*: int
# var timer*: int
# var seedtimer*: uint32
var musictimer*: uint8
# var steps* = 0 #number of steps for pet to move
# var random* = 0 #rng seed
# var selector* = left
# var gameMode* = title
var volume* = fp(0.3)
# var iterations*: int
# var joy* = true
var currframe*: int
# var dirtlevel* = clean
# var reticle*: Collider



#Actor objects
var pet* = Actor(graphic: gfxNewpet, coor: vec2f(74, 53), ca: petWalk1, cf: 0, anitimer: 0, oam: 0)
var click* = Actor(graphic: gfxClick, coor: vec2f(103, 90), ca: petIdle, cf: 0, anitimer: 0, oam: 1) #104, 48
# var balloon1* = Actor(graphic: gfxBalloon, coor: vec2f(48, -63), ca: balMove, cf: 0, anitimer: 0, oam: 2) #48, 33
# var balloon2* = Actor(graphic: gfxBalloon, coor: vec2f(138, -37), ca: balMove, cf: 0, anitimer: 0, oam: 3) #138, 72
# var balloon3* = Actor(graphic: gfxBalloon, coor: vec2f(189, -65), ca: balMove, cf: 0, anitimer: 0, oam: 4) #189, 15

var posInt*: Vec2i #integer buffer for position
var camOffset* = vec2i(-3, 0) #-10, -96
var camTarget* = vec2i(-3, 0)
var petstate* = walking

var actors*: array = [pet, click]
var remainder* = vec2f(0, 0)
var gametime* = 3000 #minigame timer
var minigameFlag* = false
# var bal1attr* = BalloonAttributes(iter: 0, dirRight: false, act: 2)
# var bal2attr* = BalloonAttributes(iter: 0, dirRight: true, act: 3)
# var bal3attr* = BalloonAttributes(iter: 0, dirRight: false, act: 4)
# var loons*: array = [bal1attr, bal2attr, bal3attr]


# #constant data
# const selectleft* = vec2i(16, 0)
# const selectmiddle* = vec2i(88, 0)
# const selectright* = vec2i(160, 0)

const offsets* = [Collider(set1:vec2f(3, 5), set2:vec2f(27, 26)), Collider(set1:vec2f(0, 0), set2:vec2f(12, 12))]


