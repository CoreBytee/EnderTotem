shell.run("set motd.enable false")
shell.run("clear")

local LocalRunning = http.get("http://localhost/") ~= nil
print(LocalRunning)

print("Fetching startup.lua from github...")
if LocalRunning then
    shell.run("wget run http://localhost/Main.lua")
else
    -- shell.run("wget run https://managedtrains.corebyte.me/Station.lua https://managedtrains.corebyte.me")
    shell.run("no")
end