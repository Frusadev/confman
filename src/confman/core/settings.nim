import Tables
import io
const settingsKeyList: seq[string] = [
  "conf_id",
  "configs: Table[string, string]",
  "main_conf: string",
]
 # Settings will be for every single configured apps
 # configured apps can be diplayed through conf-list

proc getSettings*(configId: string): Table[string, string] =
  discard
