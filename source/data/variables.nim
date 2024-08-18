import natu/[math, video, graphics, maxmod]
import anim_index
# import natu/[graphics]

type Gametypes* = enum 
    title = 0
    raisepet
    minigame

type behaviorState* = enum # pet state
    idle = 0
    walkleft
    walkright
    blink
    hungry
    eat
    bath
    laugh


type SelectPos* = enum # position of menu cursor
    left = 0
    middle
    right

type Actor* = ref object
    graphic*: Graphic
    coor*: Vec2f
    ca*: ID
    cf*: int
    anitimer*: int
    oam*: int

type Dirtrange* = enum
    clean
    dusty
    dirty
    pigsty

type Collider* = object
    set1*: Vec2f
    set2*: Vec2f

type BalloonAttributes* = object
    iter*: uint8
    dirRight*: bool
    act*: uint8
    col*: Collider

type MusicControl* = enum
    play
    fadeup
    fadedown
    silent

var musicstate* = play
var menuup* = false
var hunger*: int
var dirt*: int
var fun*: int
var timer*: int
var seedtimer*: uint32
var steps* = 0 #number of steps for pet to move
var random* = 0 #rng seed
var selector* = left
var gameMode* = title
var sound*: Sample  #for debugging purposes
var volume* = fp(0.5)
var iterations*: int
var joy* = true
var currframe*: int
var dirtlevel* = clean
var reticle*: Collider

# var textbuffer*: array[20, char]

#Actor objects
var pet* = Actor(graphic: gfxPet, coor: vec2f(104, 83), ca: petIdle, cf: 0, anitimer: 0, oam: 0)
var cursor* = Actor(graphic: gfxCursor, coor: vec2f(104, -48), ca: petIdle, cf: 0, anitimer: 0, oam: 1) #104, 48
var balloon1* = Actor(graphic: gfxBalloon, coor: vec2f(48, -63), ca: balMove, cf: 0, anitimer: 0, oam: 2) #48, 33
var balloon2* = Actor(graphic: gfxBalloon, coor: vec2f(138, -37), ca: balMove, cf: 0, anitimer: 0, oam: 3) #138, 72
var balloon3* = Actor(graphic: gfxBalloon, coor: vec2f(189, -65), ca: balMove, cf: 0, anitimer: 0, oam: 4) #189, 15

var posInt*: Vec2i #integer buffer for position
var camOffset* = vec2i(-10,-96)
var camTarget* = vec2i(-10,-96)
var petstate* = idle

var actors*: array = [pet, cursor, balloon1, balloon2, balloon3]
var remainder* = vec2f(0, 0)
var gametime* = 3000 #minigame timer
var minigameFlag* = false
var bal1attr* = BalloonAttributes(iter: 0, dirRight: false, act: 2)
var bal2attr* = BalloonAttributes(iter: 0, dirRight: true, act: 3)
var bal3attr* = BalloonAttributes(iter: 0, dirRight: false, act: 4)
var loons*: array = [bal1attr, bal2attr, bal3attr]


#constant data
const selectleft* = vec2i(16, 0)
const selectmiddle* = vec2i(88, 0)
const selectright* = vec2i(160, 0)

# const volumeFade*: array = [fp(0.0), fp(0.2), fp(0.5), fp(0.7)]
var musictimer*: uint8
