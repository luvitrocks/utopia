require('luvit-test/helper')

local http = require('http')
local utopia = require('../lib/utopia')

local PORT = process.env.PORT or 10080
local seenReq = false

local app = utopia:new()
local server = http.createServer(app.handler)

-- should be emmiter
app:on('bar', function (data)
	assert(data == 'sent data')
end)
app:emit('bar', 'sent data')

-- should have clean stack when init
equal({}, app.stack)

app:use('/foo', function (req, res)
	assert('GET' == req.method)
	assert('/foo' == req.url)
	res:finish()
end)

-- should have proper number of handlers
equal(1, #app.stack)
equal('/foo', app.stack[1].route)
equal('function', type(app.stack[1].handle))
equal('function', type(app.stack[1].handle()))

app:use(function (req, res)
	assert('GET' == req.method)
	assert('/abracadabra' == req.url)
	res:finish()
	server:close()
	seen_req = true
end)

equal(2, #app.stack)
equal('/', app.stack[2].route)
equal('function', type(app.stack[2].handle))
equal('function', type(app.stack[2].handle()))

-- should call proper handlers
server:listen(PORT, function ()
	http.get('http://127.0.0.1:' .. PORT .. '/foo')
	http.get('http://127.0.0.1:' .. PORT .. '/abracadabra')
end)

process:on('exit', function ()
	assert(seen_req)
end)
