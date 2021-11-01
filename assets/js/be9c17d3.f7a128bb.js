"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[330],{98217:function(e){e.exports=JSON.parse('{"functions":[{"name":"new","desc":"Creates a new signal.","params":[],"returns":[],"function_type":"static","source":{"line":22,"path":"src/init.lua"}},{"name":"_disconnect","desc":"Disconnects a connection from the signal.","params":[{"name":"connection","desc":"The connection to disconnect.","lua_type":"Connection"}],"returns":[],"function_type":"method","private":true,"source":{"line":41,"path":"src/init.lua"}},{"name":"Connect","desc":"Creates a new connection on the signal.\\n\\nfired.","params":[{"name":"callback","desc":"The function to call back when the signal is","lua_type":"function"}],"returns":[{"desc":"","lua_type":"Connection"}],"function_type":"method","source":{"line":59,"path":"src/init.lua"}},{"name":"Wait","desc":"Yields the thread until the signal is fired and returns the arguments the\\nsignal was fired with.","params":[],"returns":[{"desc":"","lua_type":"..."}],"function_type":"method","yields":true,"source":{"line":76,"path":"src/init.lua"}},{"name":"Fire","desc":"Fires the signal with the given arguments.","params":[{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","source":{"line":88,"path":"src/init.lua"}},{"name":"DisconnectAll","desc":"Disconnects all connections from the signal.","params":[],"returns":[],"function_type":"method","source":{"line":110,"path":"src/init.lua"}}],"properties":[{"name":"Deferred","desc":"If callbacks should be called using `task.defer()` instead of\\n`task.spawn()`. This property defaults to `false`.","lua_type":"boolean","source":{"line":15,"path":"src/init.lua"}}],"types":[],"name":"Signal","desc":"Signals emulate Roblox\'s RBXScriptSignal class.","source":{"line":8,"path":"src/init.lua"}}')}}]);