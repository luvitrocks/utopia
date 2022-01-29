# Utopia

[![Join the chat at https://gitter.im/luvit-utopia/Lobby](https://badges.gitter.im/luvit-utopia/Lobby.svg)](https://gitter.im/luvit-utopia/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/luvitrocks/utopia.svg?branch=master)](https://travis-ci.org/luvitrocks/utopia)
[![License](http://img.shields.io/badge/Licence-MIT-brightgreen.svg)](LICENSE)

> Utopia is an extensible HTTP server framework for [Luvit.io](http://luvit.io) which is using "plugins" known as middlewares and is highly inspired by [Connect.js](https://github.com/senchalabs/connect).

## Install

```bash
lit install voronianski/utopia
```

## Example

```lua
local Utopia = require('utopia')

local app = Utopia:new()

-- respond to all requests
app:use(function (req, res)
  res:finish('Hello from Utopia!')
end)

app:listen(8080)
```

## Usage

### Create an app

The main component is an "app". This will store all the middleware
added.

```lua
local app = Utopia:new()
```

### Use middleware

The core of Utopia is "using" middleware. Middleware are added as a "stack"
where incoming requests will execute each middleware one-by-one until a middleware does not call `nxt()` within it (unlike Javascript `next` is predefined function in Lua, so argument cannot be named like this).

```lua
app:use(function middleware1 (req, res, nxt)
  -- middleware 1
  nxt()
end)
app:use(function middleware2 (req, res, nxt)
  -- middleware 2
  nxt()
end)
```

### Mount middleware

The `:use()` method also takes an optional path string that is matched against
the beginning of the incoming request URL. This allows for basic routing:

```lua
app:use('/foo', function fooMiddleware (req, res, nxt)
  -- req.url starts with "/foo"
  nxt()
end)
app:use('/bar', function barMiddleware (req, res, nxt)
  -- req.url starts with "/bar"
  nxt()
end)
```

### Error middleware

There are special cases of "error-handling" middleware. There are middleware
where the function takes exactly 4 arguments. Errors that occur in the middleware added before the error middleware will invoke this middleware when errors occur.

```lua
app:use(function onerror (err, req, res, nxt) 
  -- an error occurred!
end)
```

### Create a server from the app

The last step is to actually use the Utopia app in a server. The `.listen()` method is a convenience to start a HTTP server:

```lua
local server = app:listen(port)
```

## Middlewares

- [favicon](https://github.com/luvitrocks/favicon)
- [logger](https://github.com/luvitrocks/logger)
- [request-query](https://github.com/luvitrocks/request-query)
- [body-parser](https://github.com/luvitrocks/body-parser)
- [cookie](https://github.com/luvitrocks/cookie)
- [route](https://github.com/luvitrocks/utopia-route)
- [cors](https://github.com/luvitrocks/cors)
- [json-response](https://github.com/luvitrocks/json-response)
- [static](https://github.com/luvitrocks/static)
- [directory](https://github.com/luvitrocks/directory)
- [method-override](https://github.com/luvitrocks/method-override)
- [timeout](https://github.com/luvitrocks/timeout)
- [response-time](https://github.com/luvitrocks/response-time)
- [response-methods](https://github.com/luvitrocks/http-utils#response-methods)

## Running Tests

```
lit install
luvit ./test
```

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

Copyright (c) 2014-2016 Dmitri Voronianski [dmitri.voronianski@gmail.com](mailto:dmitri.voronianski@gmail.com)

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
