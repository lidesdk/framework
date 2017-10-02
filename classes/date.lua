-- /////////////////////////////////////////////////////////////////////////////
-- // Purpose:     Date class
-- // Author:      Hernan Dario Cano [dcanohdev@gmail.com]
-- // Created:     2017-05-01
-- // Copyright:   (c) 2017 Hernan Dario Cano
-- // License:     GNU GENERAL PUBLIC LICENSE
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
---
--- >> Class constructor:
---
---   object Date:new ( string sDateCons ) 
---
---   Arguments:
---
---      sDateCons        This string is used as reference to create the object.
---
---
--- >> Class methods:
---
---      number    setDay()            Sets the day on this date
---      number    getDay()            Gets the day of this date
---      number    getMonth()          Gets the month of this date
---      number    getYear()           Gets the year of this date
---      number    getLastMonthDay()   Gets the last day of the month in this date
---      number    getFirstMonthDay()  Gets the first day of the month in this date
---      string    toString()          Convert Date to string
---

local DATE_TODAY     = 0
local DATE_YESTERDAY = 1

local number_of_days = { 
    jan = 31, feb = 28, mar = 31, apr = 30,
    may = 31, jun = 30, jul = 31, aug = 31,
    sep = 30, oct = 31, nov = 30, dec = 31,
}

local months = {
    'jan', 'feb', 'mar', 'apr', 
    'may', 'jun', 'jul', 'aug',
    'sep', 'oct', 'nov', 'dec',
}

local Date = class 'Date'

local function ftzero (num)
   local sCode = "00" .. tonumber( num )
   sCode = sCode:sub(#sCode -1, #sCode )
   return sCode
end

function Date:Date( fields )
   fields = fields or DATE_TODAY

   if ( fields == DATE_TODAY ) then
      local t = os.date '*t'
      self.Year  = t.year
        self.Month = ftzero(t.month)
        self.Day   = ftzero(t.day  )
   end
  
  if type(fields) == 'table' then
    self.Year  = fields.Year
      self.Month = fields.Month
      self.Day   = fields.Day
   end

   if type(fields) == 'string' then
      local fchar

      if fields:find '/' then 
         fchar = '/'

      elseif fields:find '-' then
         fchar = '-'
      end

      if fchar then
         local fields = fields:delim (fchar)
         self.Year  = fields[1]
         self.Month = fields[2]
         self.Day   = fields[3]
      end
   end
end

function Date:__tostring( ... )
   return ('%s-%s-%s'):format(self.Year, self:getMonth 'string', self:getDay 'string')
end

function Date:toString ( ... )  
   return self.__tostring( ... ) 
end

function Date:getYear ( ... )
   return tonumber(self.Year)
end

function Date:getDay ( what )
    if what == 'string' then
        if tonumber(self.Day) < 10 then
           return tostring ('0' .. tonumber(self.Day) )
        else
           return tostring (self.Day)
        end
    end
    return tonumber(self.Day)
end

function Date:setDay ( nDay )
   lide.core.base.isnumber(nDay)
   self.Day = nDay
   return self.Day == nDay
end

-- by default returns a number

function Date:getMonth ( ... )
    local fields  = (...) or 'number'
    
    -- fields debe ser un string...    
    if (fields == '%s') or (fields:lower() == 'name') then
        return months[tonumber(self.Month)]
    elseif (fields == '%d') or (fields:lower() == 'number') then
        return tonumber(self.Month)
    elseif fields == 'string' then
        if tonumber(self.Month) < 10 then
            return tostring('0' .. tonumber(self.Month))
        else
            return tostring(self.Month)
        end
    end
end

function Date:getFirstMonthDay()
   return 1
end

function Date:getLastMonthDay()
   --- Si la fecha es febrero y es año biciesto :)
   if ( self:getYear() % 4 == 0 ) and (self:getMonth() == 2) then
      return 29
   else
      return number_of_days[ months[self:getMonth()] ] 
   end
end

return Date

-- usage: 
--
-- birthday = Date { Year = '1996', Month = '02', Day = '29' }