import natu/[math, maxmod]
import anim_index
import natu/[graphics]

type Gametypes* = enum 
    title = 0
    raisepet
    minigame
    credits

type Direction* = enum
    up = 0
    down
    left
    right

type behaviorState* = enum # pet state
    idle = 0
    walking
    blink
    hungry
    eat
    bath
    sleep
    emote

type Color* = enum
    red = 0
    orange
    yellow
    green
    blue
    purple
    default

type Attributevalues* = object
    hunger*: uint8
    fatigue*: uint8
    hygiene*: uint8
    mood*: uint8

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


type MusicControl* = enum
    play
    fadeup
    fadedown
    silent

var musicstate* = play
var gametick*: uint16
var musictimer*: uint8
var gameMode* = title
var random* = 0 #rng seed
var volume* = fp(0.3)
var currframe*: int
var isInBathroom*: bool

var curdirection* = down

#Actor objects
var click* = Actor(graphic: gfxClick, coor: vec2f(109, 70), ca: petIdle, cf: 0, anitimer: 0, oam: 0)
var pet* = Actor(graphic: gfxNewpet, coor: vec2f(74, 53), ca: petWalk1, cf: 0, anitimer: 0, oam: 1)

var posInt*: Vec2i #integer buffer for position
# var camOffset* = vec2i(-3, 0) #-10, -96
# var camTarget* = vec2i(-3, 0)
var petstate* = walking
var petattr* = Attributevalues(hunger: 0, fatigue: 0, hygiene: 30, mood: 30)
var petcolor* = default

var actors* = [click, pet]
var remainder* = vec2f(0, 0)
# var gametime* = 3000 #minigame timer
# var minigameFlag* = false

# #constant data

const offsets* = [Collider(set1:vec2f(0, 0), set2:vec2f(12, 12)), Collider(set1:vec2f(3, 5), set2:vec2f(27, 26)), 
Collider(set1:vec2f(129, 32), set2:vec2f(157, 54)), Collider(set1:vec2f(149, 6), set2:vec2f(174, 29)), 
Collider(set1:vec2f(201, 21), set2:vec2f(228, 50))] #Pointer, Pet, Basket, Boombox, PC



