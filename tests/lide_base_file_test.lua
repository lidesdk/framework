#!/usr/bin/env lua5.1

-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/tests/lide_base_file_test.lua
-- // Purpose:   lide.base.file tests file
-- // Created:   2018/03/04
-- // Copyright: (c) 2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

require 'base.init' 	

io.stdout:write "Running lide.base 1.0 tests: "

pruebasfile = lide.file.open 'pruebasfile'
content = 'lorem ipsum, quia dolor sit amet.'

assert(pruebasfile, 'It\'s not possible to open file.')
assert(pruebasfile:write(content))
assert(content == pruebasfile:read('*a'))

io.stdout:write '[OK]\n'