local http = require('http')
local test = require('lua-tape').test
local Utopia = require('../lib/utopia')

local PORT = process.env.PORT or 10080
local seenReq = false

local app = Utopia:new()
local server = http.createServer(app.handler)

test('shoud be emmiter', function (t)
  app:on('bar', function (data)
    t:equals(data, 'sent data', 'sent valid data with emmiter')
    t:done()
  end)
  app:emit('bar', 'sent data')
end)

test('should have clean stack when init', function (t)
  t:deepEquals({}, app.stack, 'stack is empty table')

  t:done()
end)

test('should have proper request data', function (t)
  app:use('/foo', function (req, res)
    t:equals('GET', req.method, 'method is GET')
    t:equals('/foo', req.url, 'url is /foo')
    res:finish()
  end)

  t:done()
end)

test('should call proper handlers', function (t)
  local num = 1
  local firstStack = app.stack[num]

  t:equals(num, #app.stack, 'stack length is ' .. num)
  t:equals('/foo', firstStack.route, 'first stack route is /foo')
  t:equals('function', type(firstStack.handle), 'first stack handle is function')
  t:equals('function', type(firstStack.handle()), 'first stack handle returns function')

  t:done()
end)

test('should have more proper request data', function (t)
  app:use(function (req, res)
    t:equals('GET', req.method, 'method is GET')
    t:equals('/abracadabra', req.url, 'url is /abracadabra')
    res:finish()
    server:close()
    seenReq = true
  end)

  t:done()
end)

test('should call more proper handlers', function (t)
  local num = 2
  local secondStack = app.stack[num]

  t:equals(num, #app.stack, 'stack length is ' .. num)
  t:equals('/', secondStack.route, 'first stack route is /')
  t:equals('function', type(secondStack.handle), 'first stack handle is function')
  t:equals('function', type(secondStack.handle()), 'first stack handle returns function')

  t:done()
end)

test('should close server properly', function (t)
  process:on('exit', function ()
    t:ok(seenReq, 'request have been seen')
  end)

  t:done()
end)

server:listen(PORT, function ()
  http.get('http://127.0.0.1:' .. PORT .. '/foo')
  http.get('http://127.0.0.1:' .. PORT .. '/abracadabra')
end)
