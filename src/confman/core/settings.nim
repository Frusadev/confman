import Tables
import io
import parser
 # Settings will be for every single configured apps
 # configured apps can be diplayed through conf-list

proc readSettings*(confId: string) : Table[ConfKinds, string] =
  var 
    confValues: (string, string)

  try:
    confValues = readConf(confId)
    result = parseConf(confValues[1])
  except IOError:
    echo "Unable to read file: "
    result = {Unknown: "Unknown token"}.toTable()
