-- ///////////////////////////////////////////////////////////////////
-- // Name:        lide/base/init.lua
-- // Purpose:     Load base framework functions
-- // Created:     2017/11/12
-- // Copyright:   (c) 2017 Dario Cano [dcanohdev@gmail.com]
-- // License:     lide license
-- ///////////////////////////////////////////////////////////////////

-- load lide framework core
lide = lide or require 'lide.core.init'

-- load depends to filesystem:
lide.core.lib = {
	lfs = require 'lfs', -- depends to lide filesystem:
}

lide.core.file   = require 'lide.base.file';	   --> File Handling
lide.core.folder = require 'lide.base.folder';     --> Folders related
lide.file, lide.folder = lide.core.file, lide.core.folder;

lide.base.file   = lide.core.file
lide.base.folder = lide.core.folder

-- Backward compatibility:
lide.lfs = lide.core.lib.lfs; -- !Deprecated lide.lfs by lide.core.lib.lfs
----------------------------------------------------------------------

return lide