-- ///////////////////////////////////////////////////////////////////
-- // Name:      controls/button.lua
-- // Purpose:   Button class release 1.0
-- // Created:   07/07/2014
-- // Copyright:   (c) 2017 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:     GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

-- import libraries
local check = lide.core.base.check

-- import local functions:
local isObject = lide.core.base.isobject

-- import required classes
local Control = lide.classes.widgets.control

local Button = class 'Button' : subclassof 'Control'

function Button:Button ( fields )
	-- check for fields required by constructor:
	check.fields { 
	 	'string Name', 'object Parent', 'string Text'
	}
	
	-- define class fields
	private {
		DefaultPosition = { X = -1, Y = -1 }, 
		DefaultSize     = { Width = -1, Height = -1 },
		DefaultFlags    = wx.wxTAB_TRAVERSAL,

		--Parent = fields.Parent
	}

	protected {
		Text  = fields.Text,
	}
	
	-- call Control constructor
	self.super : init ( fields.Name, fields.Parent, fields.PosX or self.DefaultPosition.X, fields.PosY or self.DefaultPosition.Y, fields.Width or self.DefaultSize.Width, fields.Height or self.DefaultSize.Height, fields.ID )
	
	-- create wxWidgets object and store it on self.wxObj:
	-- wxButton(wxWindow *parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxButton" ); 
	self.wxObj = wx.wxButton(self.Parent:getwxObj(), self.ID, self.Text, wx.wxPoint( self.PosX, self.PosY ), wx.wxSize( self.Width, self.Height ), self.Flags or self.DefaultFlags, wx.wxDefaultValidator, self.Name)

	-- registry event onClick
	getmetatable(self) .__events['onClick'] = {
		data = wx.wxEVT_COMMAND_BUTTON_CLICKED,
		args = lide.core.base.voidf
	}

	self:initializeEvents {
		'onEnter', 'onLeave', 'onMotion', 'onMoving', 'onMove',

		'onLeftUp', 'onLeftDown', 'onLeftDoubleClick',

		'onClick' --> Buton Class' onClick
	}

end

function Button:getText( bMnemonic )
	if bMnemonic == nil then bMnemonic = true end; isBoolean(bMnemonic)
	
	local Text if (bMnemonic == true) then
		-- return the control's label containing mnemonics ("&" characters):
		return self.wxObj:GetLabel()
	else
		-- return the control's label without mnemonics:
		return self.wxObj:GetLabelText()
	end
end

function Button:setText ( sNewText, bMnemonic )
	if bMnemonic == nil then bMnemonic = true end; isBoolean(bMnemonic)

	if (bMnemonic == true) then
		-- return the control's label containing mnemonics ("&" characters):
		self.wxObj:SetLabel(isString(sNewText));
	else
		-- return the control's label without mnemonics:
		self.wxObj:SetLabelText(isString(sNewText));
	end

	self.Text = self.wxObj:GetLabelText();

	return (self.Text == self.wxObj:GetLabelText())
end

return Button