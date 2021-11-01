local Connection = {}
local CONNECTION_METATABLE = {}
CONNECTION_METATABLE.__index = CONNECTION_METATABLE

function Connection.new(signal, callback)
    local connection = {
        _signal = signal,
        _callback = callback,

        Connected = true,
    }

    return setmetatable(connection, CONNECTION_METATABLE)
end

function CONNECTION_METATABLE:Fire(...)
    if self._signal.Deferred then
        task.defer(self._callback, ...)
    else
        task.spawn(self._callback, ...)
    end
end

function CONNECTION_METATABLE:Disconnect()
    if self.Connected then
        self._signal:Disconnect(self)
        self.Connected = false
    end
end

return Connection