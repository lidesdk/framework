-- ///////////////////////////////////////////////////////////////////
-- // Name:        lide/base/init.lua
-- // Purpose:     Load base framework functions
-- // Created:     2017/11/12
-- // Copyright:   (c) 2017 Hernan Dario Cano [dcanohdev@gmail.com]
-- // License:     GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

-- load lide framework core
lide = lide or require 'lide.core.init'

-- Define lide.base table:
lide.base = lide.base or { 
	lib = { lfs = require 'lfs'}, -- depends for lide.file and lide.folder
}

-- Load classes:
lide.classes.file = require 'lide.classes.file'

lide.base.file   = require 'lide.base.file';	   --> File Handling
lide.base.folder = require 'lide.base.folder';     --> Folders related
lide.file, lide.folder = lide.base.file, lide.base.folder;

-- Backward compatibility:
lide.core.file   = lide.base.file
lide.core.folder = lide.base.folder
lide.lfs = lide.base.lib.lfs; -- !Deprecated lide.lfs by lide.base.lib.lfs
----------------------------------------------------------------------

-- syntax sugar: newInstanceofFile = lide.file 'aaa.txt'
--
setmetatable(lide.base.file, { 
	__call = function ( self, ... )
	   return lide.classes.file (...)
	end
});
----------------------------------------------------------------------º

return lide