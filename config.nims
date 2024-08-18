import os, strutils
import std/algorithm
import natu/config

const main = "source/life.nim"         # path to project file
const name = splitFile(main).name      # name of ROM

put "natu.gameTitle", "LIFE"          # max 12 chars, uppercase
put "natu.gameCode", "2NTP"            # 4 chars, see GBATEK for info

if projectPath() == thisDir() / main:
  # This runs only when compiling the project file:
  gbaCfg()                             # set C compiler + linker options for GBA target
  switch "os", "standalone"
  switch "gc", "arc"
  switch "define", "useMalloc"
  switch "define", "noSignalHandler"
  switch "checks", "off"               # toggle assertions, bounds checking, etc.
  switch "path", projectDir()          # allow imports relative to the main file
  switch "header"                      # output "{project}.h"
  switch "nimcache", "nimcache"        # output C sources to local directory
  switch "cincludes", nimcacheDir()    # allow external C files to include "{project}.h"

task graphics, "convert spritesheets":
  gfxConvert "gfx.nims"

task audio, "convert music and sounds":
  mmConvert "audio.nims"

task backgrounds, "convert background tilemaps":
  bgConvert "bg.nims"

task build, "builds the GBA rom":
  let args = commandLineParams()[1..^1].join(" ")
  graphicsTask()
  audioTask()
  backgroundsTask()
  selfExec "c " & args & " -o:" & name & ".elf " & thisDir() / main
  gbaStrip name & ".elf", name & ".gba"
  gbaFix name & ".gba"

task clean, "removes build files":
  rmDir "nimcache"
  rmFile name & ".gba"
  rmFile name & ".elf"
  rmFile name & ".elf.map"
