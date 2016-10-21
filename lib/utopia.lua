local Emitter = require('core').Emitter
local http = require('http')
local table = require('table')
local string = require('string')
local debug = require('debug')

local env = process.env.LUVIT_ENV or 'development'

local Utopia = Emitter:extend()

function Utopia:initialize ()
  self.route = '/'
  self.stack = {}
  self.handler = function (req, res, nxt)
    return self:handle(req, res, nxt)
  end
end

function Utopia:lazyInit ()
  if self._inited then
    return
  end

  self._inited = true

  local init = { route = '/'}
  function init:handle ()
    return function (req, res, nxt)
      res:setHeader('X-Powered-By', 'Utopia Framework')
      req.res = res
      res.req = req
      req.nxt = nxt
      req.next = nxt

      nxt()
    end
  end

  table.insert(self.stack, init)
end

function Utopia:use (route, fn)
  self:lazyInit()

  if type(route) ~= 'string' then
    fn = route
    route = '/'
  end

  -- define next stack
  local go = { route = route }
  function go:handle ()
    return fn
  end

  table.insert(self.stack, go)

  return self
end

function Utopia:handle (req, res, out)
  local index = 0

  function nxt (err)
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
        if not res.code or res.code < 400 then
          res.code = 500
        end

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

    -- skip this layer if the route doesn't match
    if not string.find(req.url, layer.route, 1, true) then
      return nxt(err)
    end

    local handle = layer:handle()

    if err then
      local arity = debug.getinfo(handle, 'u').nparams
      if arity == 4 then
        handle(err, req, res, nxt)
      else
        nxt(err)
      end
    else
      handle(req, res, nxt)
    end
  end

  nxt()

  return self
end

function Utopia:listen (...)
  local server = http.createServer(self.handler)
  return server:listen(unpack({...}))
end

return Utopia
