-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/classes/widgets/dialog.lua
-- // Purpose:   Class Dialog definition
-- // Created:   2017/05/20
-- // Copyright: (c) 2017-2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

-- import required classes:
local Window = lide.classes.widgets.window

-- define the class:

local Dialog = class 'Dialog' : subclassof 'Widget' : global (false)

function Dialog:Dialog ( fields )
	
	-- define class fields:
	private {
		DefaultPosition = { X = -1, Y = -1 }, 
		DefaultSize     = { Width = -1, Height = -1 },
		__IconFile,
	}

	protected {
		Title = fields.Title, 
		Flags = fields.Flags or wx.wxDEFAULT_FRAME_STYLE,
	}

	--- Widget ( sWidgetName, sWidgetType, nPosX, nPosY, nWidth, nHeight, nID, oParent )
	self.super : init (fields.Name, 'window', self.PosX or self.DefaultPosition.X, self.PosY or self.DefaultPosition.Y, 
		fields.Width or self.DefaultSize.Width, fields.Height or self.DefaultSize.Height, nil, nil);

	--wxDialog( );
	--wxDialog(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_DIALOG_STYLE, const wxString& name = "wxDialog" ); 
	self.wxObj = wx.wxDialog (wx.NULL, self.ID, self.Title, wx.wxPoint( self.PosX, self.PosY ), wx.wxSize( self.Width, self.Height ), self.Flags)
	
	-- initialize class events:
	self:initializeEvents {
		-- Inherited events:
		--'onEnter', 'onLeave', 'onLeftDown', 'onLeftUp',
		'onShow', 'onClose', 'onHide',
	}
end

return Dialog