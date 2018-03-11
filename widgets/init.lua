-- ///////////////////////////////////////////////////////////////////
-- // Name:        lide/widgets/init.lua
-- // Purpose:     Initialize framework
-- // Created:     2018/01/14
-- // Copyright:   (c) 2018 Hernan Dario Cano [dcanohdev@gmail.com]
-- // License:     Lide framework license
-- ///////////////////////////////////////////////////////////////////


local wx = require 'wx'

if not wx or not lide then error 'Could not load wxLua or lide' os.exit (8) end

lide.widgets = {}

lide.classes.widgets   = {}
lide.classes.controls  = {}

lide.classes.event     = require 'lide.classes.event'
lide.classes.item      = require 'lide.classes.item'
lide.classes.store     = require 'lide.classes.store'
lide.classes.date      = require 'lide.classes.date'


lide.classes.widget    = require 'lide.classes.widget'
lide.classes.menu      = require 'lide.classes.menu'
lide.classes.boxsizer  = require 'lide.classes.boxsizer'
lide.classes.gridtable = require 'lide.classes.gridtable'
lide.classes.font      = require 'lide.classes.font'
lide.classes.timer     = require 'lide.classes.timer'

lide.classes.widgets.panel  = require 'lide.classes.widgets.panel'
lide.classes.widgets.window = require 'lide.classes.widgets.window'
lide.classes.widgets.form   = require 'lide.classes.widgets.form'
lide.classes.widgets.dialog = require 'lide.classes.widgets.dialog'
lide.classes.widgets.control   = require 'lide.classes.widgets.control'

lide.classes.controls.button   = require 'lide.classes.controls.button'
lide.classes.controls.toolbar  = require 'lide.classes.controls.toolbar'
lide.classes.controls.label    = require 'lide.classes.controls.label'
lide.classes.controls.textctrl = require 'lide.classes.controls.textctrl'
lide.classes.controls.textbox  = require 'lide.classes.controls.textbox'
lide.classes.controls.grid     = require 'lide.classes.controls.grid'
lide.classes.controls.combobox = require 'lide.classes.controls.combobox'
lide.classes.controls.progress = require 'lide.classes.controls.progress'
lide.classes.controls.htmlview = require 'lide.classes.controls.htmlview'
lide.classes.controls.image    = require 'lide.classes.controls.image'
lide.classes.controls.listbox  = require 'lide.classes.controls.listbox'
lide.classes.controls.tree     = require 'lide.classes.controls.tree'
lide.classes.controls.calendar = require 'lide.classes.controls.calendar'

lide.classes.widgets.controls = lide.classes.controls

-- int wxMessageBox(const wxString& message, const wxString& caption = "Message", int style = wxOK | wxCENTRE, wxWindow *parent = NULL, int x = -1, int y = -1 ); 
function lide.widgets.messagebox ( message, caption, style, pos_x, pos_y, parent)
    return wx.wxMessageBox(message or "", caption or "Message", style or wx.wxOK + wx.wxCENTRE, parent or wx.NULL, pos_x or -1, pos_y or -1 )   
end

lide.core.base.messagebox = lide.widgets.messagebox

lide.widgets = {
    window = lide.classes.widgets.window,
    form   = lide.classes.widgets.form,
    dialog = lide.classes.widgets.dialog,
    
    -- lide.core.base.messagebox is deprecated by lide.widgets.messagebox 'msg'
    messagebox = lide.messagebox;
}

return lide