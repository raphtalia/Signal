local Signal = require(script.Parent)

return function()
    describe("Signal", function()
        it("should be able to connect", function()
            local signal = Signal.new()

            expect(function()
                signal:connect(function() end)
            end).to.be.ok()
        end)

        it("should be able to fire", function()
            local signal = Signal.new()
            local called = false
            local value

            signal:Connect(function(x)
                called = true
                value = x
            end)

            local x = math.random()
            signal:Fire(x)

            task.wait()

            expect(called).to.equal(true)
            expect(value).to.equal(x)
        end)

        it("should be able to yield for values", function()
            local signal = Signal.new()
            local value

            task.spawn(function()
                value = signal:Wait()
            end)

            local x = math.random()
            signal:Fire(x)

            expect(value).to.equal(x)
        end)

        it("should be able to disconnect all", function()
            local signal = Signal.new()
            local called = false

            local connection = signal:Connect(function()
                called = true
            end)

            signal:DisconnectAll()
            signal:Fire()

            expect(called).to.equal(false)
            expect(connection.Connected).to.equal(false)
        end)
    end)

    describe("Connection", function()
        it("should be able to disconnect", function()
            local signal = Signal.new()
            local called = false

            local connection = signal:Connect(function()
                called = true
            end)

            connection:Disconnect()
            signal:Fire()

            expect(called).to.equal(false)
            expect(connection.Connected).to.equal(false)
        end)
    end)
end