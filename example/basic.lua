local http = require('http')
local Utopia = require('../lib/utopia')

local app = Utopia:new()

app:use(function (req, res)
  res:finish('Hello from Utopia!')
end)

app:listen(8080, function ()
  print('server started on port :8080')
end)
