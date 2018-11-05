-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/init.lua
-- // Purpose:   Initialize framework
-- // Created:   2016/01/03
-- // Copyright: (c) 2016-2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

lide = require 'lide.core.init'
app  = lide.app

class = lide.class

require 'lide.base.init'

lide.file = lide.core.file

------------------------------------------
--lide.core.base.maxid = 1000-
------------------------------------------

-- Import classes to the framework:
--lide.classes = require 'lide.classes.init'

require 'lide.widgets.init'

return lide