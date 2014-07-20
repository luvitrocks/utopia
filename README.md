# luvit-utopia

Utopia is a http server framework for [luvit.io](http://luvit.io) which is using "plugins" known as middlewares. Highly inspired by [connect.js](https://github.com/senchalabs/connect).

## Install

Utopia uses [npm](https://www.npmjs.org/) as dependency manager so for installing and using it you will need latest luvit.io version (``>= 0.8.2``) and ``npm`` (this can be grabbed together with [Node.js](http://nodejs.org/)) installed on your machine.

## Usage

```lua
local utopia = require('utopia')
local http = require('http')

local app = utopia:new()

-- log every request
local logger = require('logger')
app:use(logger('dev'))

-- respond to all requests
app:use(function (req, res)
	res:finish('Hello from Utopia!')
end)

app:listen(8080)
```

## Middlewares

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
