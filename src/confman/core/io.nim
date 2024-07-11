import os
import tables
import strutils
export tables
# import parser

const paths*: Table[string, string] = {
  "confmanRoot": "~/.local/share/confman/",
  "confmanConfigs": "~/.local/share/confman/configs/",
  "appIds": "~/.local/share/confman/ids.txt",
  "confmanCache": "~/.local/share/confman/cache",
}.toTable()

proc initSettings*() : int =
  const 
    confPaths: seq[string] = @["~/.local/share/confman/", 
                               "~/.local/share/confman/configs/",
                               "~/.local/share/confman/ids.txt",
                               "~/.local/share/confman/cache/"]
  for path in confPaths:
    if not dirExists(path):
      try:
        createDir(path)
        result = 0
      except IOError: result = 1

proc readConf*(configId: string) : (string, string) =
  const 
    confPaths: string = "~/.local/share/confman/configs/"
  let appConf = confPaths[1] & configId & "/conf.cfc"

  result = (readFile(appConf), appConf)

proc getIds*() : seq[string] = 
  var idsString: string
  try:
      idsString = readFile(paths["appIds"])
  except IOError:
    echo "Unable to read ids.txt, confman will fail"
    quit()
  return split(idsString, '\n')

proc copyConfig*(origin: string, configId: string) : int =
  try:
    copyDir(origin, paths["confmanConfigs"] & config_id)
  except OSError:
    echo "failed to copy config"
    return 1

proc copyToDefault*(origin: string, root: string, configId: string) : int =
  for file in walkDir(origin):
    if dirExists(file.path):
      discard
