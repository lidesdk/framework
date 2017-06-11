-- /////////////////////////////////////////////////////////////////////////////
-- // Name:        classes/controls/calendar.lua
-- // Purpose:     Calendar class
-- // Author:      Hernan Dario Cano [dcanohdev@gmail.com]
-- // Created:     2017/05/01
-- // Copyright:   (c) 2017 Hernan Dario Cano
-- // License:     GNU GENERAL PUBLIC LICENSE
-- /////////////////////////////////////////////////////////////////////////////


-- set Combobox constants:
enum {
	CAL_SUNDAY_FIRST                = wx.wxCAL_SUNDAY_FIRST, 
	CAL_MONDAY_FIRST                = wx.wxCAL_MONDAY_FIRST, 
	CAL_SHOW_HOLIDAYS               = wx.wxCAL_SHOW_HOLIDAYS, 
	CAL_NO_YEAR_CHANGE              = wx.wxCAL_NO_YEAR_CHANGE, 
	CAL_NO_MONTH_CHANGE             = wx.wxCAL_NO_MONTH_CHANGE, 
	CAL_SHOW_SURROUNDING_WEEKS      = wx.wxCAL_SHOW_SURROUNDING_WEEKS, 
	CAL_SEQUENTIAL_MONTH_SELECTION  = wx.wxCAL_SEQUENTIAL_MONTH_SELECTION,
}

-- import libraries
local check = lide.core.base.check

-- import local functions:
local isTable   = lide.core.base.istable
local isNumber  = lide.core.base.isnumber
local isString  = lide.core.base.isstring
local isBoolean = lide.core.base.isboolean

-- import required classes
local Control = lide.classes.widgets.control

-- Define class:
local Calendar = class 'Calendar' : subclassof 'Control' : global (false)

function Calendar:Calendar ( fields )
	-- check for fields required by constructor:
	-- check ( Name, Parent ) ( 'string Name', 'object Parent' )
	-- check ( fields )
	check.fields {
		'string Name', 'object Parent' 
	}
	
	-- define class fields
	private {
		DefaultPosition = { X = 0, Y = 0 }, 
		DefaultSize     = { Width = -1, Height = -1 },
		DefaultFlags    = wx.wxCAL_SHOW_HOLIDAYS,
	}

	protected {
		Flags  = fields.Flags or self.DefaultFlags,

		DateSelected = 0
	}

--		-- call Control constructor
	self.super : init ( fields.Name, fields.Parent, fields.PosX or self.DefaultPosition.X, fields.PosY or self.DefaultPosition.Y, fields.Width or self.DefaultSize.Width, fields.Height or self.DefaultSize.Height, fields.ID )
	
	-- create wxWidgets object and store it on self.wxObj:
	-- wxCalendarCtrl(wxWindow* parent, wxWindowID id, const wxDateTime& date = wxDefaultDateTime, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCAL_SHOW_HOLIDAYS, const wxString& name = "wxCalendarCtrl" );
	self.wxObj = wx.wxCalendarCtrl (self.Parent:getwxObj(), self.ID, wx.wxDefaultDateTime, wx.wxPoint( self.PosX, self.PosY ), wx.wxSize( self.Width, self.Height ), self.Flags or self.DefaultFlags, self.Name)
	
	-- define the interface to wxCalendarEvent:
	local function wxCalendarEventInterface ( event )
		local date = event:GetDate()
		local year, month, day = date:GetYear(), date:GetMonth()+1, date:GetDay()
		
		self.DateSelected = lide.classes.date (('%s/%s/%s') : format (year, month, day))

		return year, month, day
	end

	-- registry event onClick
	-- The selected date changed.
	getmetatable(self) .__events['onSelChanged'] = {
		data = wx.wxEVT_CALENDAR_SEL_CHANGED,-- 
		args = wxCalendarEventInterface
	}

	getmetatable(self) .__events['onDayChanged'] = {
		data = wx.wxEVT_CALENDAR_DAY_CHANGED,-- 
		args = lide.core.base.voidf
	}

	getmetatable(self) .__events['onMonthChanged'] = {
		data = wx.wxEVT_CALENDAR_MONTH_CHANGED,-- 
		args = lide.core.base.voidf
	}

	getmetatable(self) .__events['onYearchanged'] = {
		data = wx.wxEVT_CALENDAR_YEAR_CHANGED,-- 
		args = lide.core.base.voidf
	}

	getmetatable(self) .__events['onDoubleClicked'] = {
		data = wx.wxEVT_CALENDAR_DOUBLECLICKED,
		args = wxCalendarEventInterface,
	}

	getmetatable(self) .__events['onWeekdayClicked'] = {
		data = wx.wxEVT_CALENDAR_WEEKDAY_CLICKED,
		args = lide.core.base.voidf
	}


	self:initializeEvents {
		'onDoubleClicked', 'onSelChanged'
	}
end

--#if !%wxchkver_2_9_2 
--void EnableYearChange(bool enable = true ); 
--#endif 
function Calendar:enableYearChange ( enable )
	if enable == nil then enable = true end
	self.wxObj:EnableYearChange(enable)
end

--void EnableMonthChange(bool enable = true ); 
function Calendar:enableMonthChange( enable )
	if enable == nil then enable = true end
	self.wxObj:EnableMonthChange(enable)
end

--void EnableHolidayDisplay(bool display = true ); 
function Calendar:enableHolidayDisplay( display )
	if display == nil then display = true end
	self.wxObj:EnableHolidayDisplay(display)
end

function Calendar:getBind ( ... )
	return self.wxObj
end

function Calendar:getSelectedDate( ... )
	return self.DateSelected
end

return Calendar

--class wxCalendarCtrl : public wxControl 
--{
--wxCalendarCtrl(wxWindow* parent, wxWindowID id, const wxDateTime& date = wxDefaultDateTime, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCAL_SHOW_HOLIDAYS, const wxString& name = "wxCalendarCtrl" ); 
--//bool Create(wxWindow* parent, wxWindowID id, const wxDateTime& date = wxDefaultDateTime, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCAL_SHOW_HOLIDAYS, const wxString& name = "wxCalendarCtrl" ); 
--
--void SetDate(const wxDateTime& date ); 
--wxDateTime GetDate() const; 
--



--void SetHeaderColours(const wxColour& colFg, const wxColour& colBg ); 
--wxColour GetHeaderColourFg() const; 
--wxColour GetHeaderColourBg() const; 
--void SetHighlightColours(const wxColour& colFg, const wxColour& colBg ); 
--wxColour GetHighlightColourFg() const; 
--wxColour GetHighlightColourBg() const; 
--void SetHolidayColours(const wxColour& colFg, const wxColour& colBg ); 
--wxColour GetHolidayColourFg() const; 
--wxColour GetHolidayColourBg() const; 
--wxCalendarCtrlDateAttr* GetAttr(size_t day) const; 
--void SetAttr(size_t day, %ungc wxCalendarCtrlDateAttr* attr); // will delete previously set attr as well 
--void SetHoliday(size_t day ); 
--void ResetAttr(size_t day ); 
----
----// %override [wxCalendarCtrlHitTestResult, wxDateTime date, wxDateTime::WeekDay wd] wxCalendarCtrl::HitTest(const wxPoint& pos ); 
----// C++ Func: wxCalendarCtrlHitTestResult HitTest(const wxPoint& pos, wxDateTime* date = NULL, wxDateTime::WeekDay* wd = NULL ); 
----wxCalendarCtrlHitTestResult HitTest(const wxPoint& pos ); 
----}; 
----
----// --------------------------------------------------------------------------- 
----// wxCalendarCtrlDateAttr 
----
--class %delete wxCalendarCtrlDateAttr 
--{
--wxCalendarCtrlDateAttr( ); 
--wxCalendarCtrlDateAttr(const wxColour& colText, const wxColour& colBack = wxNullColour, const wxColour& colBorder = wxNullColour, const wxFont& font = wxNullFont, wxCalendarCtrlDateBorder border = wxCAL_BORDER_NONE ); 
--wxCalendarCtrlDateAttr(wxCalendarCtrlDateBorder border, const wxColour& colBorder = wxNullColour ); 
--
--void SetTextColour(const wxColour& colText ); 
--void SetBackgroundColour(const wxColour& colBack ); 
--void SetBorderColour(const wxColour& col ); 
--void SetFont(const wxFont& font ); 
--void SetBorder(wxCalendarCtrlDateBorder border ); 
--void SetHoliday(bool holiday ); 
--bool HasTextColour() const; 
--bool HasBackgroundColour() const; 
--bool HasBorderColour() const; 
--bool HasFont() const; 
--bool HasBorder() const; 
--bool IsHoliday() const; 
--wxColour GetTextColour() const; 
--wxColour GetBackgroundColour( ); 
--wxColour GetBorderColour() const; 
--wxFont GetFont() const; 
--wxCalendarCtrlDateBorder GetBorder( ); 
--}; 
--


-- #define wxCB_DROPDOWN 
-- #define wxCB_READONLY 
-- #define wxCB_SIMPLE 
-- #define wxCB_SORT 

-- class wxCombobox : public wxControl, public wxItemContainer 
-- {
-- wxCombobox( ); 
-- wxCombobox(wxWindow* parent, wxWindowID id, const wxString& value = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxCombobox" ); 
-- bool Create(wxWindow* parent, wxWindowID id, const wxString& value = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxCombobox" ); 

-- bool CanCopy() const; 
-- bool CanCut() const; 
-- bool CanPaste() const; 
-- bool CanRedo() const; 
-- bool CanUndo() const; 
-- void Copy( ); 
-- void Cut( ); 
-- %wxchkver_2_8 virtual int GetCurrentSelection() const; 
-- long GetInsertionPoint() const; 
-- long GetLastPosition() const; 
-- wxString GetValue() const; 
-- void Paste( ); 
-- void Redo( ); 
-- void Replace(long from, long to, const wxString& text ); 
-- void Remove(long from, long to ); 
-- void SetInsertionPoint(long pos ); 
-- void SetInsertionPointEnd( ); 
-- void SetSelection(long from, long to ); 
-- void Undo( ); 
-- }; 


-- Possible kinds of borders which may be used to decorate a date using wxCalendarDateAttr.
-- enum wxCalendarCtrlDateBorder 
-- {
-- wxCAL_BORDER_NONE, 
-- wxCAL_BORDER_SQUARE, 
-- wxCAL_BORDER_ROUND 
-- }; 