import api
import cmdutils

const
  paramTypes*: seq[string] = @[
    "number",
    "string",
    "boolean"
  ]

type
  Command* = ref object
    commandString: string
    # parameter flag: -d..., and parameter value type: int, string...
    commandParams: Table[string, string]
    runFunction: proc(params: Table[string, string]): void
    commandDescription: string


proc initCommand*(commandName: string) : Command =
  var
    cmd = new(Command)
  cmd.commandString = commandName
  return cmd

proc initCommand*(commandName: string, commandParams: Table[string, string]) : Command =
  var
    cmd = new(Command)
  cmd.commandString = commandName
  cmd.commandParams = commandParams
  return cmd

proc initCommand*(commandName: string, commandParams: Table[string, string], runFunction: proc) : Command =
  var cmd = new(Command)
  cmd.commandString = commandName
  cmd.commandParams = commandParams
  cmd.runFunction = runFunction

proc runCommand*(cmd: Command) =
  cmd.runFunction(cmd.commandParams)

proc matchCommandCallback*(commandName: string) : proc =
  var
    callBack: proc(params: Table[string, string])
  # Known callbacks:
    # set config
    # add confv
    # backup
    # restore from
  case commandName
    of "set-config":
      callBack = setConfig
    of "add-confv":
      callBack = addConfigVersion
    of "backup":
      callBack = backupConfig
    of "restore-from":
      callBack = restoreFrom

proc parseCommnad*(input: string) : Command =
  let
    refinedInput = splitCommandParams(input)
    commandName = refinedInput[0]
    commandArgs: seq =
      if refinedInput.len > 1:
        refinedInput[1..refinedInput.len - 1]
      else:
        @[]

  var
    commandParams: Table[string, string]
    currentArgKey: string = ""
    currentArgVal: string

  # determining the argument names and values
  commandParams = toParamTable(commandArgs)

proc listen() =
  while true:
    let
      input: string = readLine(stdin)
