import os
import parser

proc initSettings*() : int =
  const 
    confPaths: seq[string] = @["~/.local/share/confman", 
                               "~/.local/share/confman/configs",
                               "~/.local/share/confman/cache/"]
  for path in confPaths:
    if not dirExists(path):
      createDir(path)

proc readConf*(configId: string) =
  const 
    confPaths: string = "~/.local/share/confman/configs/"
  let appConf = confPaths & configId & "/conf.cfc"
  
  for lines in readLines(appConf, n = 3):
    discard
