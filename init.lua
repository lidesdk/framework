-- /////////////////////////////////////////////////////////////////////////////////////////////////
-- // Name:        init.lua
-- // Purpose:     Initialize framework
-- // Author:      Dario Cano [dcanohdev@gmail.com]
-- // Created:     2016/01/03
-- // Copyright:   (c) 2014 -2017 Dario Cano
-- // License:     MIT License/X11 license
-- /////////////////////////////////////////////////////////////////////////////////////////////////
--

lide = require 'lide.core.init'
app  = lide.app

--> lide.core.file is deprecated by lide.file
lide.file = lide.core.file

------------------------------------------
lide.core.base.maxid = 1000
------------------------------------------

-- Import classes to the framework:
lide.classes = require 'lide.classes.init'

return lide
