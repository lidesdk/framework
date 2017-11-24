-- /////////////////////////////////////////////////////////////////////////////////////////////////
-- // Name:        lide/classes/init.lua
-- // Purpose:     Initialize framework classes
-- // Author:      Dario Cano [dcanohdev@gmail.com]
-- // Created:     2017/11/12
-- // Copyright:   (c) 2014 -2017 Dario Cano
-- // License:     MIT License/X11 license
-- /////////////////////////////////////////////////////////////////////////////////////////////////

---
--- lide.core:
lide.classes           = lide.classes or {}
lide.classes.object    = require 'lide.classes.object'
lide.classes.item      = require 'lide.classes.item'
lide.classes.store     = require 'lide.classes.store'
lide.classes.date      = require 'lide.classes.date'

--- lide.file:
--- depends: lide.lfs
lide.classes.file      = require 'lide.classes.file'

return lide.classes