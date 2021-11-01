local Connection = require(script.Connection)

--[=[
    @class Signal

    Signals emulate Roblox's RBXScriptSignal class.
]=]
--[=[
    @within Signal
    @prop Deferred boolean

    If callbacks should be called using `task.defer()` instead of
    `task.spawn()`. This property defaults to `false`.
]=]
local Signal = {}
local SIGNAL_METATABLE = {}
SIGNAL_METATABLE.__index = SIGNAL_METATABLE

--[=[
    Creates a new signal.
]=]
function Signal.new()
    local signal = {
        _connections = {},
        _yields = {},

        Deferred = false,
    }

    return setmetatable(signal, SIGNAL_METATABLE)
end

--[=[
    @within Signal
    @private

    @param connection Connection -- The connection to disconnect.

    Disconnects a connection from the signal.
]=]
function SIGNAL_METATABLE:_disconnect(connection)
    connection = table.find(self._connections, connection)

    if connection then
        table.remove(self._connections, connection)
    end
end

--[=[
    @within Signal

    Creates a new connection on the signal.

    @param callback function -- The function to call back when the signal is
    fired.

    @return Connection
]=]
function SIGNAL_METATABLE:Connect(callback)
    local connection = Connection.new(self, callback)

    table.insert(self._connections, connection)

    return connection
end

--[=[
    @within Signal
    @yields

    Yields the thread until the signal is fired and returns the arguments the
    signal was fired with.

    @return ...
]=]
function SIGNAL_METATABLE:Wait()
    table.insert(self._yields, coroutine.running())
    return coroutine.yield()
end

--[=[
    @within Signal

    Fires the signal with the given arguments.

    @param ... any
]=]
function SIGNAL_METATABLE:Fire(...)
    if self.Deferred then
        for _,connection in ipairs(self._connections) do
            task.defer(connection._callback, ...)
        end
    else
        for _,connection in ipairs(self._connections) do
            task.spawn(connection._callback, ...)
        end
    end

    for _,thread in ipairs(self._yields) do
        coroutine.resume(thread, ...)
    end
    table.clear(self._yields)
end

--[=[
    @within Signal

    Disconnects all connections from the signal.
]=]
function SIGNAL_METATABLE:DisconnectAll()
    for _,connection in ipairs(self._connections) do
        connection:Disconnect()
    end
end

return Signal