#!/usr/bin/env lua5.1

-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/tests/lide_error_test.lua
-- // Purpose:   lide.error tests file
-- // Created:   2017/04/07
-- // Copyright: (c) 2017-2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

lide  = require 'core.init'

io.stdout:write "Running lide.core.error 1.0 tests: "

assert(lide.core.lua.type(lide.error) == 'table'   , 'Module lide.error was not loaded.')
assert(lide.core.lua.type(try)        == 'function', 'try function does not exists.')
assert(lide.core.lua.type(catch)      == 'function', 'catch function does not exists.')
assert(lide.core.lua.type(finally)    == 'function', 'finally function does not exists.')

try { function ()
       
       function hello(name)
           lide.error.is_string(name)
       end

       hello 'Hernan'

       function sum( one, two )
       	  lide.error.is_number(one)
       	  lide.error.is_number(two)

       	  return one + two
       end

       assert(sum(2,3)==2+3)
   end,

catch {
   function( err )
       if err:isa(lide.error.TypeException) then
          print(err)
       end
   end
  }
}

assert (lide.error.newException)
assert (lide.error.TypeError)
assert (lide.error.is_number)
assert (lide.error.is_string)
assert (try)
assert (catch)
assert (finally)

io.stdout:write '[OK]\n'