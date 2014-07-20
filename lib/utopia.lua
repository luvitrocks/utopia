local Object = require('core').Object
local Proto = require('./app')

local Utopia = Object:extend()

function Utopia:initialize()
	local app = Proto:new()

	app.handler = function (req, res, follow)
		return app:handle(req, res, follow)
	end

	return app
end
