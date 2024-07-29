import natu/[math]
import natu/[graphics]

type Gametypes* = enum 
    title = 0
    raisepet
    minigame

type behaviorState* = enum # pet state
    idle = 0
    walkleft
    walkright

var hunger*: int
var dirt*: int
var fun*: int
var timer*: int
var steps* = 0 #number of steps for pet to move
var random* = 0 #rng seed


var petpos* = vec2f(104, 83)
var posInt* = vec2i(petpos) #integer buffer for pet position
var camOffset* = vec2i(-10,-96)
var camTarget* = vec2i(-10,-96)
var cursorpos* = vec2i(104, 48)

var graphic*: Graphic


var petstate* = idle


var gametime* = 1200 #minigame timer
