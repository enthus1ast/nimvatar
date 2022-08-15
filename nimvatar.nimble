# Package

version       = "0.1.0"
author        = "David Krause"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["server"]


# Dependencies

requires "nim >= 1.6.4"
requires "jester"
requires "nimja"
requires "pixie"