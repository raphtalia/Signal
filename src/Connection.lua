--[=[
    @class Connection

    Connections emulate Roblox's RBXScriptConnection class.
]=]
--[=[
    @within Connection
    @prop Connected boolean
    @readonly

    If the connection to the signal is still alive.
]=]
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

--[=[
    @within Connection

    Disconnects the connection from its signal.
]=]
function CONNECTION_METATABLE:Disconnect()
    if self.Connected then
        self._signal:_disconnect(self)
        self.Connected = false
    end
end

return Connection