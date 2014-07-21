local Object = require('core').Object
local http = require('http')
local table = require('table')
local debug = require('debug')

local env = process.env.LUVIT_ENV or 'development'

local Utopia = Object:extend()

function Utopia:initialize ()
	self.route = '/'
	self.stack = {}
	self.handler = function (req, res, follow)
		return self:handle(req, res, follow)
	end
end

function Utopia:use (route, fn)
	if type(route) ~= 'string' then
		fn = route
		route = '/'
	end

	-- define next stack
	local go = { route = route }
	function go:handle () return fn end

	table.insert(self.stack, go)

	return app
end

function Utopia:handle (req, res, out)
	local index = 0

	function follow (err)
		local layer

		index = index + 1
		layer = self.stack[index]

		-- all done
		-- NB: this could be moved into separate module (e.g. node's https://github.com/expressjs/finalhandler)
		if not layer then
			-- delegate to parent
			if out then return out(err) end

			-- unhandled error
			if err then
				local msg

				-- default to 500
				if res.code < 400 then res.code = 500 end

				-- respect err.status
				if type(err) == 'table' and err.status then
					res.code = err.status
				end

				-- basic error message for production
				if env == 'production' then
					msg = http.STATUS_CODES[res.code]
				else
					if err.status and err.msg then
						msg = err.status .. ' ' .. err.msg
					else
						msg = tostring(err) or 'Unknown server error'
					end
				end

				res:setHeader('Content-Type', 'text/html')
				res:setHeader('Content-Length', #msg)
				res:finish(msg)
			else
				res.code = 404
				res:setHeader('Content-Type', 'text/html')
				if 'HEAD' == req.method then return res:finish() end
				res:finish('Cannot ' .. req.method .. ' ' .. req.url)
			end

			return
		end

		local handle = layer:handle()

		if err then
			local arity = debug.getinfo(handle, 'u').nparams
			if arity == 4 then
				handle(err, req, res, follow)
			else
				follow(err)
			end
		else
			handle(req, res, follow)
		end
	end

	follow()
end

function Utopia:listen (...)
	local server = http.createServer(self.handler)
	return server:listen(unpack({...}))
end

return Utopia
