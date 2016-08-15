-- for older versions of luvit and alternative package managers
return {
  name = "voronianski/utopia",
  version = "1.0.0-beta",
  description = "High performance middleware framework for Luvit.io",
  repository = {
    url = "http://github.com/luvitrocks/luvit-utopia.git",
  },
  tags = {"utopia", "express", "connect"},
  author = {
    name = "Dmitri Voronianski",
    email = "dmitri.voronianski@gmail.com"
  },
  homepage = "https://github.com/luvitrocks/luvit-utopia",
  licenses = {"MIT"},
  main = 'init.lua'
}

return {
  name = "creationix/mylib",
  version = "0.0.1",
  files = {
    "*.lua",
  }
}
