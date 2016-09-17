-- ///////////////////////////////////////////////////////////////////////////////
-- // Name:        lide.core.init.lua
-- // Purpose:     Define and initialize framework values
-- // Created:     2016/01/03
-- // Copyright:   (c) 2016 Dario Cano [hdcano@protonmail.com]
-- // License:     lide license
-- ///////////////////////////////////////////////////////////////////////////////

-- EXPERIMENTAL FILE.

require 'lide.core.thlua' --> import

lide = lide or {
	cons   = {}, 	--> This table saves all constants
	errorf = {}, 	--> This table stores all error functions
	
	core   = {
		error = {},	--> stores all variables related to exceptions control
		base  = {},
		lua   = { type = type },
		file  = {},  --> stores all variables related to file handling
	},

	classes = {
		widgets  = {},
		controls = {},
	}, 	--> stores all classes

	platform = {},
}

lide.core.error = require 'lide.core.error' 	--> exceptions control
lide.core.oop   = require 'lide.core.oop.init'  --> OOP handling
lide.core.base  = require 'lide.core.base'		-->
lide.core.file  = require 'lide.core.file'		--> File Handling

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
	if (io.popen('uname -s'):read '*l' == 'Linux') then
		return 'Linux';
	elseif (io.popen('DIR /b %WinDIR%\\Explorer.Exe & Ver & Exit'):read '*l') then
		return 'Windows';
	end
end

return lide