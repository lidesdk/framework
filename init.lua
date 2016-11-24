-- /////////////////////////////////////////////////////////////////////////////////////////////////
-- // Name:        init.lua
-- // Purpose:     Initialize framework
-- // Author:      Dario Cano [dario.canohdz@gmail.com]
-- // Created:     2016/01/03
-- // Copyright:   (c) 2014 Dario Cano
-- // License:     MIT License/X11 license
-- /////////////////////////////////////////////////////////////////////////////////////////////////
--
-- GNU/Linux Lua version:   5.1.5
-- Windows x86 Lua version: 5.1.4

lide = require 'lide.core.init'
app  = lide.app

if not wx then
	--if lide.platform:getOSName() == 'Linux' then
	--	wx = package.loadlib (lide.app.sourcefolder..'/wx.so', 'luaopen_wx')()
	--elseif lide.platform:getOSName() == 'Windows' then
	--	wx = package.loadlib ('./wx.dll', 'luaopen_wx')()
	--end
	local _lide_path = os.getenv 'LIDE_PATH'

	if lide.platform.getOSName() == 'Linux' then
--		package.cpath = --'?.so;./?.so;./clibs/?.so;' ..
--					    _lide_path .. '/?.so;' ..
--					    _lide_path .. '/clibs/?.so;' --..
					    --_lide_path ..'/libraries/?.so;'  ..
					    --_lide_path ..'/libraries/linux_x86/?.so;'

		wx = require 'wx'
		
		--package.path  = _lide_path ..'/libraries/?.lua;'  ..
		--				_lide_path ..'/libraries/?/init.lua;'  ..
		--				_lide_path ..'/?.lua;'  ..
		--				package.path 
		
	elseif lide.platform.getOSName() == 'Windows' then
		--package.cpath = ';?.dll;.\\?.dll;'
		--package.path  = ';?.lua;.\\?.lua;'
		--package.cpath = ';.\\?.dll;' ..
		--			    _lide_path .. '\\?.dll;'
		
		--wx = require 'wx'
		wx = package.loadlib ((_sourcefolder or '.') ..'\\wx.dll', 'luaopen_wx') ()
		lide.lfs = package.loadlib ((_sourcefolder or '.') ..'\\lfs.dll', 'luaopen_lfs') ()
	else
		print 'lide: error fatal: plataforma no soportada.'
	end

	if not wx then lide.core.error.lperr 'No se pudo cargar wxLua' os.exit(1) end
end

--> lide.core.file is deprecated by lide.file
lide.file = lide.core.file

--package.path =  app.getWorkDir() .. '/?.lua;' ..
--				app.getWorkDir() .. '/?/init.lua;' ..
--				package.path 

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

----------------------------------------------------------------------
lide.core.base.maxid = 1000
------------------------------------------

--- Get the architecture of the runnig operating system.
---		Returns one value: a string like "32 bit" or "64 bit"
---
--- string getOSVersion( nil )
function lide.platform.getArchName( ... )
	return wx.wxPlatformInfo:Get():GetArchName()
end

--- Get the version of the operating system.
---		Returns two numbers: Major version, Minor version
---
--- number, number getOSVersion( nil )
function lide.platform.getOSVersion( ... )
	return wx.wxPlatformInfo:Get():GetOSMajorVersion(), wx.wxPlatformInfo:Get():GetOSMinorVersion()
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

-- int wxMessageBox(const wxString& message, const wxString& caption = "Message", int style = wxOK | wxCENTRE, wxWindow *parent = NULL, int x = -1, int y = -1 ); 
function lide.core.base.messagebox ( message, caption, style, pos_x, pos_y, parent)
	return wx.wxMessageBox(message or "", caption or "Message", style or wx.wxOK + wx.wxCENTRE, parent or wx.NULL, pos_x or -1, pos_y or -1 )	
end


local function normalizePath ( path )
	if lide.platform.getOSName() == 'Linux' then
		return path:gsub('\\', '/');
	elseif lide.platform.getOSName() == 'Windows' then
		return path:gsub('/', '\\');
	end
end


-- Import classes to the framework:
lide.classes = require 'lide.classes.init'

local _lide_libs = os.getenv 'LIDE_PATH' .. '/libraries'



if lide.platform.getOSName() == 'Linux' then
	package.cpath = '?/init.so;?.so;' ..      -- WORK FOLDER
					_lide_libs .. '/linux_x86/clibs/?.so;' ..  -- LIDE LIBS
					_lide_libs .. '/linux_x86/clibs/?/init.so' -- LIDE LIBS

	--package.path  = '?/init.lua;?.lua;' ..      -- WORK FOLDER
	--			_lide_libs .. '/linux_x86/?.lua;' ..  -- LIDE LIBS
	--			_lide_libs .. '/linux_x86/?/init.lua;' .. -- LIDE LIBS
--
--	--			_lide_libs .. '/?.lua;' ..  -- LIDE LIBS
	--			_lide_libs .. '/?/init.lua;' -- LIDE LIBS

	package.path  = 
				_lide_libs .. '/linux_x86/lua/?.lua;' ..  -- LIDE LIBS
				_lide_libs .. '/linux_x86/lua/?/init.lua;' ..-- LIDE LIBS

				_lide_libs .. '/?.lua;' ..  -- LIDE LIBS
				_lide_libs .. '/?/init.lua;'-- .. -- LIDE LIBS

elseif lide.platform.getOSName() == 'Windows' then
	package.cpath = 
					_lide_libs .. '\\windows_x86\\clibs\\?.dll;' ..  -- LIDE LIBS
					_lide_libs .. '\\windows_x86\\clibs\\?init.dll;' ..-- LIDE LIBS

					'?\\init.dll;?.dll;' .. ''     -- WORK FOLDER
	
	package.path  = 
				_lide_libs .. '\\windows_x86\\lua\\?.lua;' ..  -- LIDE LIBS
				_lide_libs .. '\\windows_x86\\lua\\?\\init.lua;' ..-- LIDE LIBS

				_lide_libs .. '\\?.lua;' ..  -- LIDE LIBS
				_lide_libs .. '\\?\\init.lua;'-- .. -- LIDE LIBS

				--'?\\init.lua;?.lua;' ..     '' -- WORK FOLDER
	
	package.path  = normalizePath(package.path)
	package.cpath = normalizePath(package.cpath)
end

return lide