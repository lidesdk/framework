lide.core.file = { }

-- simple test to see if the file exits or not
function lide.core.file.doesExists( sFilename )
    local file = io.open(sFilename , 'rb')
    if (file == nil) then return false end
    io.close(file)
    return true
end

return lide.core.file