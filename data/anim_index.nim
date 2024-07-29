import natu/[graphics]

type frame* = object
    index*, duration*: int

type Frameset* = seq[frame]

type Anim* = object
    data*: Frameset
    a_timer*: int

     
var anim*: Anim

const pethappy*: Frameset = [
    frame(0, 1) 
]

const petblink*: Frameset = [
    frame(1, 4)
]

const petchew*: Frameset = [
    frame(3, 2), frame(4, 2), frame(5, 2)
]

const petwalk*: Frameset = [
    frame(7, 1), frame(8, 1)
]