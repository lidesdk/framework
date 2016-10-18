lide.folder = {}

function lide.folder.create ( dest )
	io.popen('mkdir ' .. dest)
end

-- simple test to see if the file exits or not
function lide.folder.doesExists( sFolderName )
    local file = io.open(sFolderName , 'rb')
    if (file == nil) then return false end
    file:close()
    return true
end

return lide.folder