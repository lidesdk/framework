-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/classes/timer.lua
-- // Purpose:   Timer class
-- // Created:   2014/07/07
-- // Copyright: (c) 2014-2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

local Timer = class 'Timer' 

	--: global( false )


-- define class:
function Timer:Timer ( nID, fTimerHandler )
	self.wxEvtHandler = wx.wxEvtHandler()
	self.ID = nID
	self.wxObj = wx.wxTimer(self.wxEvtHandler, self.ID)

	self.wxEvtHandler:Connect(wx.wxEVT_TIMER, function ( event )
		local Interval, nID = event:GetInterval(), event:GetId()		
		fTimerHandler( nID, Interval ) -- call user's event handler with arguments
	end)
end

function Timer:getwxObj( )
	return self.wxObj
end

-- define class methods:
function Timer:start( Milliseconds , Oneshot ) 
	if (Oneshot == nil) then
		Oneshot = false
	end
	return self.wxObj:Start(Milliseconds, Oneshot)	
end

function Timer:stop()
	self.wxObj:Stop()
end

function Timer:getInterval()
	return self.wxObj:GetInterval()
end

function Timer:isOneShot()
	return self.wxObj:IsOneShot()
end

function Timer:isRunning()
	return self.wxObj:IsRunning()
end

return Timer