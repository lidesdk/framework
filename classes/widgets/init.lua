-- ///////////////////////////////////////////////////////////////////////////////
-- // Name:        lide/widgets/init.lua
-- // Purpose:     define functions required by framework graphical interfaces
-- // Author:      Hernan Dario Cano [dcanohdev@gmail.com]
-- // Created:     2017/11/10
-- // Copyright:   (c) 2017 Hernan Dario Cano
-- // License:     lide license
-- ///////////////////////////////////////////////////////////////////////////////

-- lide.widgets:
-- depends: lide.wx = require 'wx'

if not wx then
	wx = require 'wx'

	if not wx then error 'No se pudo cargar wxLua' os.exit() end
end

lide.core.base.enum {
	HELP        = wx.wxHELP, 
	CANCEL      = wx.wxCANCEL, 
	YES_NO      = wx.wxYES_NO, 
	OK_DEFAULT  = wx.wxOK_DEFAULT, 
	YES_DEFAULT = wx.wxYES_DEFAULT,
	NO_DEFAULT  = wx.wxNO_DEFAULT,
	YES         = wx.wxYES,
	NO          = wx.wxNO,
	OK 		    = wx.wxOK, 
}

----------------------------------------------------------------------
--- Alignment constants:
--	used by BoxSizer,

enum -- wxAlignment 
{
    ALIGN_NOT    = wx.wxALIGN_NOT, 
    ALIGN_LEFT   = wx.wxALIGN_LEFT, 
    ALIGN_TOP    = wx.wxALIGN_TOP, 
    ALIGN_RIGHT  = wx.wxALIGN_RIGHT, 
    ALIGN_BOTTOM = wx.wxALIGN_BOTTOM, 
    ALIGN_CENTER = wx.wxALIGN_CENTER, 
    ALIGN_CENTRE = wx.wxALIGN_CENTRE, 
    ALIGN_MASK   = wx.wxALIGN_MASK,
    
    ALIGN_CENTER_HORIZONTAL = wx.wxALIGN_CENTER_HORIZONTAL, 
    ALIGN_CENTRE_HORIZONTAL = wx.wxALIGN_CENTRE_HORIZONTAL, 
    ALIGN_CENTER_VERTICAL   = wx.wxALIGN_CENTER_VERTICAL, 
    ALIGN_CENTRE_VERTICAL   = wx.wxALIGN_CENTRE_VERTICAL, 
}


enum { -- wxMessageDialog
 	 ICON_ASTERISK    = wx.wxICON_ASTERISK ,
 	 ICON_ERROR  	  = wx.wxICON_ERROR,
 	 ICON_EXCLAMATION = wx.wxICON_EXCLAMATION,
 	 ICON_HAND  	  = wx.wxICON_HAND,
 	 ICON_INFORMATION = wx.wxICON_INFORMATION,
 	 ICON_MASK  	  = wx.wxICON_MASK,
 	 ICON_QUESTION    = wx.wxICON_QUESTION,
 	 ICON_STOP  	  = wx.wxICON_STOP,
 	 ICON_WARNING     = wx.wxICON_WARNING,
 }

lide.classes.timer     = require 'lide.classes.timer'
lide.classes.font      = require 'lide.classes.font'
lide.classes.event     = require 'lide.classes.event'
lide.classes.widget    = require 'lide.classes.widget'
lide.classes.menu      = require 'lide.classes.menu'
lide.classes.boxsizer  = require 'lide.classes.boxsizer'
lide.classes.gridtable = require 'lide.classes.gridtable'

lide.classes.widgets.panel  = require 'lide.classes.widgets.panel'
lide.classes.widgets.window = require 'lide.classes.widgets.window'
lide.classes.widgets.form   = require 'lide.classes.widgets.form'
lide.classes.widgets.dialog = require 'lide.classes.widgets.dialog'

lide.classes.widgets.control       = require 'lide.classes.widgets.control'
lide.classes.controls.button       = require 'lide.classes.controls.button'
lide.classes.controls.toolbar      = require 'lide.classes.controls.toolbar'
lide.classes.controls.label        = require 'lide.classes.controls.label'
lide.classes.controls.textctrl     = require 'lide.classes.controls.textctrl'
lide.classes.controls.textbox      = require 'lide.classes.controls.textbox'
lide.classes.controls.grid         = require 'lide.classes.controls.grid'
lide.classes.controls.combobox     = require 'lide.classes.controls.combobox'
lide.classes.controls.progress     = require 'lide.classes.controls.progress'
lide.classes.controls.htmlview     = require 'lide.classes.controls.htmlview'
lide.classes.controls.image        = require 'lide.classes.controls.image'
lide.classes.controls.listbox      = require 'lide.classes.controls.listbox'
lide.classes.controls.tree         = require 'lide.classes.controls.tree'
lide.classes.controls.calendar     = require 'lide.classes.controls.calendar'

lide.classes.widgets.controls = lide.classes.controls

return lide.classes.widgets, lide.classes.controls
