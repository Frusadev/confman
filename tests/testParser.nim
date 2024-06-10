import unittest
import ../src/confman/core/parser
import Tables

suite "Config parser tests":
  test "conf id test":
    check(parseConf("wezterm") == {CONF_ID: "wezterm"}.toTable())

  test "configs test":
    check(parseConf("configs: wez1, wez2") == {CONFIGS: "wez1,wez2"}.toTable())

  test "array parse test":
    check(extractList(parseConf("configs: wez1, wez2")[CONFIGS]) == @["wez1", "wez2"])
