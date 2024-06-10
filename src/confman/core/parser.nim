import Tables
import strutils

type 
  ConfKinds* = enum 
    CONF_ID
    CONFIGS
    MAIN_CONF
    Unknown

proc extractList*(s: string) : seq[string] =
  var 
    currentElm: string
    values: seq[string]

  for c in s:
    if not (c == ','):
      currentElm.add(c)
    else:
      values.add(currentElm)
      currentElm = ""
  # Add the last element after the loop has ended 
  values.add(currentElm)

  return values

proc parseConf*(s: string) : Table[ConfKinds, string] =
  const 
    confList: seq[string] = @["conf_id", "configs", "main_conf"]
    confTable: Table[string, ConfKinds] = {
      "conf_id": CONF_ID,
      "configs": CONFIGS,
      "main_conf": MAIN_CONF
    }.toTable()

  var 
    currentWord: string = ""
    key: ConfKinds
    value: string

  if not (':' in s):
    return {CONF_ID: s}.toTable()
  else:
    var 
      encounteredColon: bool = false
    for c in s:
      if not encounteredColon:
        if not (c == ':'):
          currentWord.add(c)
        else:
          encounteredColon = true 
          if currentWord in confList:
            key = confTable[currentWord]
            currentWord = ""
          else: 
            key = Unknown
            value = "nil"
      else:
        currentWord.add(c)
    value = currentWord

  return {key: value.replace(" ", "")}.toTable()
