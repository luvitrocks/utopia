require('luvit-test/helper')

local http = require('http')
local utopia = require('../lib/utopia')

local app = utopia:new()

equal({}, app.stack)
