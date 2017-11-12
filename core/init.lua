-- ///////////////////////////////////////////////////////////////////////////////
-- // Name:        lide.core.init.lua
-- // Purpose:     Define and initialize framework values
-- // Created:     2016/01/03
-- // Copyright:   (c) 2016 Dario Cano [dcanohdev@gmail.com]
-- // License:     lide license
-- ///////////////////////////////////////////////////////////////////////////////

io.stdout:setvbuf 'no'
io.stderr:setvbuf 'no'

lide = lide or {
	cons   = {}, 	--> This table saves all constants
	errorf = {}, 	--> This table stores all error functions
	
	core   = {
		error  = {},  --> stores all variables related to exceptions control
		base   = {},
		lua    = { type = type, error = error, require = require },
		file   = {},  --> stores all variables related to file handling
		folder = {},
	},

	classes = {
		widgets  = {},
		controls = {},
	}, 	--> stores all classes

	platform = {},
	app = {}
}

local app = lide.app

-- core functions:

function lide.app.getWorkDir( ... )
	if lide.platform.getOSName() == 'Linux' then
		return io.popen 'echo $PWD' : read '*l'
	elseif lide.platform.getOSName() == 'Windows' then
		--return io.popen 'CD' : read '*l'
		return lide.lfs.currentdir()
	else
		lide.core.error.lperr 'this function is not implemented on this platform.'
	end
end

-- if interpreter
if arg and arg[0] then
	local sf = arg[0]:sub(1, #arg[0] , #arg[0])
	local n  = sf:reverse():find (package.config:sub(1,1), 1) or 0
		  sf = sf:reverse():sub (n+1, # sf:reverse()) : reverse()

	_sourcefolder = sf
end

require 'lide.core.thlua'

lide.core.error  = require 'lide.core.error' 	 --> exceptions control
lide.core.oop    = require 'lide.core.oop.init'  --> OOP handling
lide.core.base   = require 'lide.core.base'		 -->

-- load lide framework depends:
lide.core.lib = {
	lfs = require 'lfs', -- depends to lide filesystem:
}

-- load lide.platform:
lide.core.platform = require 'lide.core.platform'; 
lide.platform = lide.core.platform;

-- load lide.file and lide.folder:
lide.core.file   = require 'lide.core.file';		--> File Handling
lide.core.folder = require 'lide.core.folder';      --> Folders related
lide.file, lide.folder = lide.core.file, lide.core.folder;

-- Backward compatibility:
lide.lfs    = lide.core.lib.lfs; -- !Deprecated lide.lfs by lide.core.lib.lfs

----------------------------------------------------------------------
-- define base framework values:
lide.enum  = lide.core.base.enum;
lide.class = lide.core.oop.class;

-- Backward compatibility:
enum  = lide.enum    -- !Deprecated enum by lide.enum 
class = lide.class   -- !Deprecated class by lide.class

return lide, lide.app