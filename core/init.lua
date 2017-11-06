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

lide.core.error  = require 'lide.core.error' 	--> exceptions control
lide.core.oop    = require 'lide.core.oop.init'  --> OOP handling
lide.core.base   = require 'lide.core.base'		-->

-- lide platform
lide.platform    = require 'lide.platform.init'

--local os_linux   = lide.platform.getOSName():lower() == 'linux'
--local os_windows = lide.platform.getOSName():lower() == 'windows'
local os_arch    = lide.platform.getOSArch():lower();
local os_name    = lide.platform.getOSName():lower();

local _lide_path = os.getenv('LIDE_PATH');

if (not _lide_path) then
    lide.core.error.lperr 'LIDE_PATH is not defined now.'
end

-- lide filesystem:
lide.lfs 		 = require 'lfs'
--------------------------------

lide.core.file   = require 'lide.core.file'		--> File Handling
lide.core.folder = require 'lide.core.folder'   --> Folders related


------------------------------------------
lide.folder = lide.core.folder;
lide.file   = lide.core.file;

------------------------------------------
-- base values:

class = lide.core.oop.class
enum  = lide.core.base.enum

--package.path  = package_path
--package.cpath = package_cpath

return lide, lide.app