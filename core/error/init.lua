-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/core/error/init.lua
-- // Purpose:   Initialize error handling framework
-- // Created:   2018/03/04
-- // Copyright: (c) 2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

assert( class or lide.class, "lide.error: requires lide.class" )

local ltrace = require 'lide.core.error.ltrace'

--====================================================================--
--== Setup, Constants

local DEFAULT_PREFIX     = 'ERROR: '
local DEFAULT_ERRMSG     = 'LuaException'
local DEFAULT_STACKLEVEL = 3
local REM_NUM_STACKS     = 4

--====================================================================--
--== Support Functions

-- based on https://gist.github.com/cwarden/1207556

local function try( funcs )
	local try_f, catch_f, finally_f = funcs[1], funcs[2], funcs[3]
	assert( try_f, 'lua-error: missing function for try()' )
	
	REM_NUM_STACKS = 6
	
	local status, result = pcall(try_f)
	if not status and catch_f then
		catch_f(result)
	end
	if finally_f then finally_f() end
	return result
end

local function catch(f)
	return f[1]
end

local function finally(f)
	REM_NUM_STACKS = nil
	return f[1]
end

--====================================================================--
--== Class Exception
--====================================================================--

local Object = lide.classes.object

local Exception = class 'Exception' : subclassof ( Object )

local DEFAULT_ERROR_NAME = Exception:name()

function Exception:Exception ( sExceptionName, sDefaultErrMsg )
	assert(type(sExceptionName) == 'string', 'arg must be a string.')
	
	if sDefaultErrMsg then
		assert(type(sDefaultErrMsg) == 'string', 'arg must be a string.')
	end

    public {
   		message = sDefaultErrMsg or DEFAULT_ERRMSG,
   		traceback = '',
	}

	private {
   		name   = sExceptionName or DEFAULT_ERROR_NAME,
   		values = {}
	}

   self.super : init (self.name)
end

function Exception:__call ( message, nlevel )	
	self.nlevel       = nlevel or DEFAULT_STACKLEVEL
	
	local maxstack    = (#ltrace.getstack(self.nlevel) - REM_NUM_STACKS)
	
	self.message   = self:getName() .. ': ' .. (message or self.message)
	self.traceback = self.message .. '\n\n' .. ltrace.getfulltrace(self.nlevel, maxstack);
	
	lide.core.lua.error (self)
end

function Exception:__tostring( ... )
	return self.traceback
end

function Exception:isa ( ExceptionObject )
	return self:getName() == ExceptionObject:getName()
end

--====================================================================--
--== Class Error
--====================================================================--

local StandardError = class 'StandardError' : subclassof ( Exception )

function StandardError:StandardError ( message, nlevel )
	
	assert(type(message) == 'string', 'error message must be string.');
	assert(type(nlevel) == 'number', 'stack level must be number.');

	public { 
		message = message or DEFAULT_ERRMSG,
		nlevel  = nlevel  or DEFAULT_STACKLEVEL
	}
	
	self . super :init ('LuaException', message)
	
	lide.core.lua.error(self.message, self.nlevel)
end

function StandardError:__tostring( ... )
	return table.concat( { self.message, "\n", self.traceback } )
end

--====================================================================--
--== Create Default framework Exceptions
--====================================================================--

local TypeError = Exception :new 'TypeError'

local function istype( ValueToCompare, TypeToCompare )
	local errmsg = errmsg or ('type is incorrect, must be %s.'):format(TypeToCompare)
	
	if lide.core.base.type(ValueToCompare) == TypeToCompare then 
		return ValueToCompare 
	else 
		if not errmsg then 
			return false ;
		else 
			TypeError(errmsg, DEFAULT_STACKLEVEL +1-1);
		end 
	end
end

StandardError : enum { 

	DEFAULT_STACKLEVEL = DEFAULT_STACKLEVEL,

	TypeError = TypeError,

	newException = function ( sExceptionName, sDefaultErrMsg )
   		return Exception :new ( sExceptionName, sDefaultErrMsg );
	end ,

	is_number = function ( value, errmsg )
		return istype(value, 'number');
	end,

	is_string = function ( value, errmsg )
		return istype(value, 'string');
	end,

	is_function = function ( value, errmsg )
		return istype(value, 'function');
	end,

	is_object = function ( value, errmsg )
		return istype(value, 'object');
	end,

	is_boolean = function ( value, errmsg )
		return istype(value, 'boolean');
	end,

	is_table = function ( value, errmsg )
		return istype(value, 'table');
	end,

	try     = try,
	catch   = catch,
	finally = finally,
}

--====================================================================--
--== Error API Setup
--====================================================================--

_G.try = try
_G.catch = catch
_G.finally = finally

getmetatable(StandardError).__tostring = function ( ... )
	return '[lide.error] namespace' 
end

return StandardError