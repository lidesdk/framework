-- ///////////////////////////////////////////////////////////////////
-- // Name:      controls/checkbox.lua
-- // Purpose:   checkbox class release 1.0
-- // Created:   08/11/2018
-- // Copyright: (c) 2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

-- import libraries
local check = lide.core.base.check

-- import local functions:
local isObject  = lide.core.base.isobject
local isBoolean = lide.core.base.isboolean
local isString  = lide.core.base.isstring

-- import required classes
local Control = lide.classes.widgets.control

local Checkbox = class 'Checkbox' : subclassof (Control);

Checkbox:enum {
	CHK_2STATE  = wx.wxCHK_2STATE,
	CHK_3STATE  = wx.wxCHK_3STATE,
	ALIGN_RIGHT = wx.wxALIGN_RIGHT,
	CHK_ALLOW_3RD_STATE_FOR_USER = wx.wxCHK_ALLOW_3RD_STATE_FOR_USER,
}

function Checkbox:Checkbox ( fields )
	
	-- check for fields required by constructor:
	check.fields { 
	 	'object Parent', 'string Text', 'string Name'
	}
	
	-- define class fields
	private {
		DefaultPosition = { X = -1, Y = -1 }, 
		DefaultSize     = { Width = -1, Height = -1 },
		DefaultFlags    = wx.wxTAB_TRAVERSAL,

		Parent = fields.Parent
	}

	protected {
		Text  = fields.Text,
	}
	
	-- call Control constructor
	self.super : init ( fields.Name, fields.Parent, fields.PosX or self.DefaultPosition.X, fields.PosY or self.DefaultPosition.Y, fields.Width or self.DefaultSize.Width, fields.Height or self.DefaultSize.Height, fields.ID )
	
	-- create wxWidgets object and store it on self.wxObj:
	-- wxCheckBox(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& val = wxDefaultValidator, const wxString& name = "wxCheckBox" ); 
	-- bool Create(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& val = wxDefaultValidator, const wxString& name = "wxCheckBox" ); 
	local self_Parent;
	if ( self.Parent:getWidgetType() == 'window' ) then
		self_Parent = self.Parent.Panel;
	else
		self_Parent = self.Parent;
	end

	self.wxObj = wx.wxCheckBox(self_Parent:getwxObj(), self.ID, self.Text, wx.wxPoint( self.PosX, self.PosY ), wx.wxSize( self.Width, self.Height ), self.Flags or self.DefaultFlags, wx.wxDefaultValidator, self.Name)

	-- registry event onClick
	getmetatable(self) .__events['onClick'] = {
		data = wx.wxEVT_COMMAND_CHECKBOX_CLICKED,
		args = function ( event )
			local _isChecked = event:IsChecked();

			return _isChecked
		end
	}

	self:initializeEvents {
	
	-- LideMouseEvents from Widget Class:
		'onEnter', 'onLeave', 'onMotion', ---> 'onMoving', 'onMove',

	--	'onLeftUp', 'onLeftDown', 'onLeftDoubleClick',

		'onClick' --> Checkbox Class' onClick
	}

end

function Checkbox:getValue ( ... )
	return self.wxObj:GetValue()
end

--enum wxCheckBoxState 
--wxCHK_UNCHECKED, 
--wxCHK_CHECKED, 
--wxCheckBoxState Get3StateValue() const; 
function Checkbox:get3StateValue()
--wxCHK_UNDETERMINED 
	return self.wxObj:Get3StateValue()
end

--bool Is3rdStateAllowedForUser() const; 
function Checkbox:is3rdStateAllowedForUser()
	return self.wxObj:Is3rdStateAllowedForUser()
end

--bool Is3State() const; 
function Checkbox:is3State()
	return self.wxObj:Is3State()
end

--bool IsChecked() const; 
function Checkbox:isChecked()
	return self.wxObj:IsChecked()
end

--void SetValue(const bool state ); 
function Checkbox:setValue ( bState )
	return self.wxObj:SetValue( bState )
end

--void Set3StateValue(const wxCheckBoxState state ); 
function Checkbox:set3StateValue ( nCheckBoxState )
	return self.wxObj:Set3StateValue( nCheckBoxState )
end

return Checkbox