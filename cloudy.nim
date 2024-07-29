import natu/[video, math]
import sprite

var currentcloud = 0
var cloudobj: ObjAttr 

proc CloudsSpawn()=
    for i in 1..4:
        currentcloud = i
        sprite_init(self: cloud(&i), g: gfxCloud, pos = vec2i(20, 30))
        cloudobj = cloud(&i)
        objMem[i] = cloudobj

proc MoveClouds()=
    