-- ///////////////////////////////////////////////////////////////////////////////
-- // Name:        lide.core.init.lua
-- // Purpose:     Define and initialize framework values
-- // Created:     2016/01/03
-- // Copyright:   (c) 2016 Dario Cano [hdcano@protonmail.com]
-- // License:     lide license
-- ///////////////////////////////////////////////////////////////////////////////

lide = lide or {
	cons   = {}, 	--> This table saves all constants
	errorf = {}, 	--> This table stores all error functions
	
	core   = {
		error  = {},	--> stores all variables related to exceptions control
		base   = {},
		lua    = { type = type },
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

local sf = arg[0]:sub(1, #arg[0] , #arg[0])
local n  = sf:reverse():find ('/', 1 )
	  sf = sf:reverse():sub (n+1, # sf:reverse()) : reverse()

lide.app.sourcefolder = sf

local app = lide.app

function app.getWorkDir( ... )
	if lide.platform.getOSName() == 'Linux' then
		return io.popen 'echo $PWD' : read '*l'
	elseif lide.platform.getOSName() == 'Windows' then
		return io.popen 'CD' : read '*l'
	else
		lide.core.error.lperr 'this function is not implemented on this platform.'
	end
end

require 'lide.core.thlua'

lide.core.error  = require 'lide.core.error' 	--> exceptions control
lide.core.oop    = require 'lide.core.oop.init'  --> OOP handling
lide.core.base   = require 'lide.core.base'		-->
lide.core.file   = require 'lide.core.file'		--> File Handling
lide.core.folder = require 'lide.core.folder'   --> Folders related

------------------------------------------
lide.folder = lide.core.folder;
lide.file   = lide.core.file;

------------------------------------------
-- base values:

class = lide.core.oop.class
enum  = lide.core.base.enum

-- core functions:

--- Get the name of the operating system.
---		Returns one string: OS Name like "Linux"
---
--- string getOSVersion( nil )

function lide.platform.getOSName( ... )
	if (package.config:sub(1,1) == '/') then
		return 'Linux';
	elseif (package.config:sub(1,1) == '\\') then
		return 'Windows';
	end
end

return lide, lide.app