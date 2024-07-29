import natu/[math, video, bios]
import natu/[graphics]
import variables

proc camInit*()=
    VBlankIntrWait()
    bgofs[1].x = (-camOffset.x).int16
    bgofs[1].y = (-camOffset.y).int16


proc Snapcam*(p = Vec2i)=
    camOffset = p
    camTarget = camOffset

proc camScroll*()=
    if camTarget.y > camOffset.y:
        #cameraOffset = camTarget
        camOffset.y += 1
        #skyOffset.y += 1
        #bgofs[s].x = (-camOffset.x).int16
        #bgofs[1].y = (-camOffset.y).int16
        petpos.y += 1
        #bgofs[0].y = (-skyOffset.y).int16
        #for obj in mitems(objMem):
        #    obj.y = obj.y + 1.int16
       

    elif camTarget.y < camOffset.y:
        camOffset.y -= 1
        #skyOffset.y -= 1
        #bgofs[s].x = (-camOffset.x).int16
        #bgofs[1].y = (-camOffset.y).int16
        petpos.y -= 1
        #bgofs[0].y = (-skyOffset.y).int16
        #for obj in mitems(objMem):
        #    obj.y = obj.y - 1.int16
    
    #bgofs[1] = initBgPoint(-camOffset)

    #s += 1
    #if s == 8:
        #objMem[1] = obj
        #pos.x += 1
        #s = 0
   


