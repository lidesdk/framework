#!/usr/bin/env lua5.1

-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/tests/lide_core_oop_test.lua
-- // Purpose:   lide.core.oop tests file
-- // Created:   2018/03/04
-- // Copyright: (c) 2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

package.path = "?.lua;" .. package.path

-- -x create class
-- -x instance class
-- -x getters
-- -x setters
-- -x access modifiers
-- -x methods
-- - heritage

io.stdout:write "Running lide.core.oop 1.0 tests: "

	-- load only core lua framework:
	class = require 'core.init' .class
	
assert(type(class) == 'function', 'lide.core.oop: keyword class (or lide.class) was not loaded.')

	-- create class
	local newClass = class 'newClass'

assert(tostring(newClass) == 'class newClass', 'lide.core.oop: error creating class')

	newClass:enum {
		CONST = 111,
	}

assert(newClass.CONST == 111, 'lide.core.oop: error creating class constant')

	function newClass:newClass ( ... )
		protected {
			value = 0,
		}
		
		private {
			_value = 1,
		}

		public {
			prop = 'type12'
		}
	end

	function newClass:get_value( ... )
		return self.value 
	end
	
	function newClass:set_value( value )
		self.value = value
		return self.value == value
	end
	
	function newClass:get_pvalue( ... )
		return self._value 
	end
	
	function newClass:set_pvalue( value )
		self._value = value
		return self._value == value
	end

	-- instance class
	local newInstance = newClass:new()

assert(newInstance, 'lide.core.oop: error instantiating class')

-- getters:
assert(newInstance:get_value(), 'lide.core.oop: error calling get method')
	
-- setters:
assert(newInstance:set_value(3), 'lide.core.oop: error calling set method')
assert(newInstance:get_value() == 3, 'lide.core.oop: error protected values cant be accesed?')
assert(newInstance:set_value(6), 'lide.core.oop: error protected values cant be modified?')

assert(newInstance:set_pvalue(9), 'lide.core.oop: error private values cant be modified?')
assert(newInstance:get_pvalue() == 9, 'lide.core.oop: error private values cant be accesed?')

assert(newInstance.prop == 'type12', 'lide.core.oop: error public values cant be accesed?')

assert(newInstance.value == nil, 'lide.core.oop: error protected values are exposed!')
assert(newInstance._value == nil, 'lide.core.oop: error private values are exposed!')

io.stdout:write '[OK]\n'