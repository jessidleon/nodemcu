local function log(msg)
    file.open("log", "a+")
    file.writeline(msg)
    file.close()
    print(msg)
end

return {log = log}
