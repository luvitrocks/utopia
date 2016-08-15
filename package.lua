return {
  name = "voronianski/utopia",
  version = "1.0.0",
  main = 'init.lua',
  description = "High performance middleware framework for Luvit.io",
  repository = {
    url = "http://github.com/luvitrocks/luvit-utopia.git",
  },
  tags = {"utopia", "express", "connect", "middleware", "server"},
  author = {
    name = "Dmitri Voronianski",
    email = "dmitri.voronianski@gmail.com"
  },
  homepage = "https://github.com/luvitrocks/luvit-utopia",
  licenses = {"MIT"},
  dependencies = {},
  files = {
    "**.lua",
    "!test*"
  }
}
