local Connection = require(script.Connection)

local Signal = {}
local SIGNAL_METATABLE = {}
SIGNAL_METATABLE.__index = SIGNAL_METATABLE

function Signal.new()
    local signal = {
        _connections = {},
        _yields = {},

        Deferred = false,
    }

    return setmetatable(signal, SIGNAL_METATABLE)
end

function SIGNAL_METATABLE:Connect(callback)
    local connection = Connection.new(self, callback)

    table.insert(self._connections, connection)

    return connection
end

function SIGNAL_METATABLE:Wait()
    table.insert(self._yields, coroutine.running())
    return coroutine.yield()
end

function SIGNAL_METATABLE:Fire(...)
    for _,connection in ipairs(self._connections) do
        connection:Fire(...)
    end

    for _,thread in ipairs(self._yields) do
        coroutine.resume(thread, ...)
    end
    table.clear(self._yields)
end

function SIGNAL_METATABLE:Disconnect(connection)
    connection = table.find(self._connections, connection)

    if connection then
        table.remove(self._connections, connection)
    end
end

function SIGNAL_METATABLE:DisconnectAll()
    for _,connection in ipairs(self._connections) do
        connection:Disconnect()
    end
end

return Signal