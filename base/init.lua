-- base.lua
-- load lide.file and lide.folder:

lide = lide or require 'lide.core.init'

lide.core.file   = require 'lide.base.file';	   --> File Handling
lide.core.folder = require 'lide.base.folder';     --> Folders related
lide.file, lide.folder = lide.core.file, lide.core.folder;

lide.base.file   = lide.core.file
lide.base.folder = lide.core.folder

-- Backward compatibility:
lide.lfs = lide.core.lib.lfs; -- !Deprecated lide.lfs by lide.core.lib.lfs
----------------------------------------------------------------------

return lide