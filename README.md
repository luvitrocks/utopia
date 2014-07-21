# luvit-utopia

[![NPM version](https://badge.fury.io/js/luvit-utopia.svg)](http://badge.fury.io/js/luvit-utopia)

Utopia is a http server framework for [luvit.io](http://luvit.io) which is using "plugins" known as middlewares. Highly inspired by [connect.js](https://github.com/senchalabs/connect).

## Install

Utopia uses [npm](https://www.npmjs.org/) as dependency manager so for installing and using it you will need latest [luvit.io](http://luvit.io/dist/latest/) version (``>= 0.8.2``) and ``npm`` (this can be grabbed together with [node.js](http://nodejs.org/)) installed on your machine.

```bash
npm install luvit-utopia
```

## Usage

```lua
local utopia = require('luvit-utopia')

local app = utopia:new()

-- log every request
local logger = require('luvit-logger')
app:use(logger('dev'))

-- respond to all requests
app:use(function (req, res)
	res:finish('Hello from Utopia!')
end)

app:listen(8080)
```

## Middlewares

- [luvit-favicon](https://github.com/luvitrocks/luvit-favicon)
- [luvit-logger](https://github.com/luvitrocks/luvit-logger)
- [luvit-static](https://github.com/luvitrocks/luvit-static)

## License

```
WWWWWW||WWWWWW
 W W W||W W W
      ||
    ( OO )__________
     /  |           \
    /o o|    MIT     \
    \___/||_||__||_|| *
         || ||  || ||
        _||_|| _||_||
       (__|__|(__|__|
```

MIT Licensed

Copyright (c) 2014 Dmitri Voronianski [dmitri.voronianski@gmail.com](mailto:dmitri.voronianski@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
