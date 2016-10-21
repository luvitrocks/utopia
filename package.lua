return {
  name = 'voronianski/utopia',
  version = '1.0.3',
  description = 'High performance middleware framework for Luvit.io',
  repository = {
    url = 'http://github.com/luvitrocks/utopia.git',
  },
  tags = {'utopia', 'express', 'connect', 'middleware', 'server'},
  author = {
    name = 'Dmitri Voronianski',
    email = 'dmitri.voronianski@gmail.com'
  },
  homepage = 'https://github.com/luvitrocks/utopia',
  licenses = {'MIT'},
  dependencies = {
    'filwisher/lua-tape'
  },
  files = {
    '**.lua',
    '!test*',
    '!example*'
  }
}
