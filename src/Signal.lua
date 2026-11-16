
local Signal = {}
Signal.__index = Signal

local Connection = {}
Connection.__index = Connection

function Connection:Disconnect()
    if not self.Connected then
        return
    end

    self.Connected = false

    local signal = self.Signal
    self.Signal = nil

    if signal then
        for i = #signal._connections, 1, -1 do
            if signal._connections[i] == self then
                table.remove(signal._connections, i)
                break
            end
        end
    end
end

function Signal.new()
    return setmetatable({
        _connections = {},
        _destroyed = false
    }, Signal)
end

function Signal:Connect(callback)
    assert(type(callback) == "function", "Callback must be a function")
    assert(not self._destroyed, "Signal has been destroyed")

    local connection = setmetatable({
        Callback = callback,
        Connected = true,
        Signal = self
    }, Connection)

    table.insert(self._connections, connection)

    return connection
end

function Signal:Once(callback)
    local connection

    connection = self:Connect(function(...)
        connection:Disconnect()
        callback(...)
    end)

    return connection
end

function Signal:Fire(...)
    if self._destroyed then
        return
    end

    local connections = table.clone(self._connections)

    for _, connection in ipairs(connections) do
        if connection.Connected then
            connection.Callback(...)
        end
    end
end

function Signal:Wait()
    assert(not self._destroyed, "Signal has been destroyed")

    local thread = coroutine.running()

    self:Once(function(...)
        task.spawn(thread, ...)
    end)

    return coroutine.yield()
end

function Signal:DisconnectAll()
    for _, connection in ipairs(table.clone(self._connections)) do
        connection:Disconnect()
    end
end

function Signal:Destroy()
    if self._destroyed then
        return
    end

    self._destroyed = true
    self:DisconnectAll()
end

return Signal
