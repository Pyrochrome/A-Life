# Generated by natu

import natu/[memory, oam, utils]


type
  Graphic* = enum
    gfxPet
    gfxBall
    gfxBerry
    gfxSoap
    gfxCursor
    gfxCloud
    gfxBalloon

block:
  {.compile:"./graphics.c".}

let palData {.importc:"natuGfxPalData", extern:"natuGfxPalData", codegenDecl:"extern const $# $#".}: array[53, char]
let imgData {.importc:"natuGfxImgData", extern:"natuGfxImgData", codegenDecl:"extern const $# $#".}: array[7553, char]

const staticGfxData: array[Graphic, GraphicData] = [
  gfxPet: GraphicData(bpp: 4, size: s32x32, flags: {}, w: 32, h: 32, imgPos: 0, imgWords: 1280, palNum: 0, palPos: 0, palHalfwords: 4, frames: 10, frameWords: 128),
  gfxBall: GraphicData(bpp: 4, size: s16x16, flags: {}, w: 16, h: 16, imgPos: 5120, imgWords: 32, palNum: 1, palPos: 8, palHalfwords: 4, frames: 1, frameWords: 32),
  gfxBerry: GraphicData(bpp: 4, size: s16x16, flags: {}, w: 16, h: 16, imgPos: 5248, imgWords: 32, palNum: 2, palPos: 16, palHalfwords: 5, frames: 1, frameWords: 32),
  gfxSoap: GraphicData(bpp: 4, size: s16x16, flags: {}, w: 16, h: 16, imgPos: 5376, imgWords: 32, palNum: 3, palPos: 26, palHalfwords: 3, frames: 1, frameWords: 32),
  gfxCursor: GraphicData(bpp: 4, size: s32x32, flags: {}, w: 32, h: 32, imgPos: 5504, imgWords: 128, palNum: 4, palPos: 32, palHalfwords: 3, frames: 1, frameWords: 128),
  gfxCloud: GraphicData(bpp: 4, size: s32x32, flags: {}, w: 32, h: 32, imgPos: 6016, imgWords: 128, palNum: 5, palPos: 38, palHalfwords: 3, frames: 1, frameWords: 128),
  gfxBalloon: GraphicData(bpp: 4, size: s32x32, flags: {}, w: 32, h: 32, imgPos: 6528, imgWords: 256, palNum: 6, palPos: 44, palHalfwords: 4, frames: 2, frameWords: 128),
]

var palUsages {.codegenDecl:EWRAM_DATA.}: array[7, uint16]

template data*(g: Graphic): GraphicData = staticGfxData[g]
template palUsage*(g: Graphic): var uint16 = palUsages[g.data.palNum]
template palDataPtr*(g: Graphic): pointer = unsafeAddr palData[g.data.palPos]
template imgDataPtr*(g: Graphic): pointer = unsafeAddr imgData[g.data.imgPos]

