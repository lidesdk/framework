-- /////////////////////////////////////////////////////////////////////////////////////////////////
-- // Name:        init.lua
-- // Purpose:     Initialize framework
-- // Author:      Dario Cano [dcanohdev@gmail.com]
-- // Created:     2016/01/03
-- // Copyright:   (c) 2014 -2017 Dario Cano
-- // License:     MIT License/X11 license
-- /////////////////////////////////////////////////////////////////////////////////////////////////
--
-- GNU/Linux Lua version:   5.1.5
-- Windows x86 Lua version: 5.1.4

lide = require 'lide.core.init'
app  = lide.app

--> lide.core.file is deprecated by lide.file
lide.file = lide.core.file

------------------------------------------
lide.core.base.maxid = 1000
------------------------------------------

-- int wxMessageBox(const wxString& message, const wxString& caption = "Message", int style = wxOK | wxCENTRE, wxWindow *parent = NULL, int x = -1, int y = -1 ); 
function lide.core.base.messagebox ( message, caption, style, pos_x, pos_y, parent)
	return wx.wxMessageBox(message or "", caption or "Message", style or wx.wxOK + wx.wxCENTRE, parent or wx.NULL, pos_x or -1, pos_y or -1 )	
end

-- Import classes to the framework:
lide.classes = require 'lide.classes.init'

return lide
