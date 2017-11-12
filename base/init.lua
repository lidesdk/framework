-- ///////////////////////////////////////////////////////////////////
-- // Name:        lide/base/init.lua
-- // Purpose:     Load base framework functions
-- // Created:     2017/11/12
-- // Copyright:   (c) 2017 Dario Cano [dcanohdev@gmail.com]
-- // License:     lide license
-- ///////////////////////////////////////////////////////////////////

-- load lide framework core
lide = lide or require 'lide.core.init'

-- Define lide.base table:
lide.base = lide.base or { 
	lib = { lfs = require 'lfs'}, -- depends for lide.file and lide.folder
}

lide.base.file   = require 'lide.base.file';	   --> File Handling
lide.base.folder = require 'lide.base.folder';     --> Folders related
lide.file, lide.folder = lide.base.file, lide.base.folder;

-- Backward compatibility:
lide.core.file   = lide.base.file
lide.core.folder = lide.base.folder
lide.lfs = lide.base.lib.lfs; -- !Deprecated lide.lfs by lide.base.lib.lfs
----------------------------------------------------------------------

return lide