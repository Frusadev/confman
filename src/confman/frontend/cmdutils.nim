import api

proc splitCommandParams*(input: string) : seq[string] =
  let
    splitInput: seq[string] = split(input, " ")

  var
    argConstruct: string
    args: seq[string]
    inQuote: bool = false

  for s in splitInput:
    if s.startsWith("\""):
      inQuote = true
      # Then we'll need to find the closing quote
      var unQuotedS = s
      unQuotedS.removePrefix("\"")
      argConstruct.add(unQuotedS)
    else:
      if not inQuote:
        args.add(s)
      else:
        if s.endsWith("\""):
          inQuote = false
          var unQuotedS = s
          unQuotedS.removeSuffix("\"")
          argConstruct.add(unQuotedS)
          args.add(argConstruct)
        else:
          argConstruct.add(" " & s)
  return args

proc toParamTable*(rawParams: seq[string]) : Table[string, string] =
  var
    currentParamKey: string
    argTable: Table[string, string]

  for paramString in rawParams:
    if paramString.startsWith("-"):
      currentParamKey = paramString
      currentParamKey.removePrefix("-")
    else:
      argTable[currentParamKey] = paramString

  return argTable
