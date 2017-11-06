#!/usr/bin/env lua5.1

-- load only core lua framework without classes
local lide = require 'lide.core.init'

-- Testear si existe la palabra clave 'class'
io.stdout:write 'classes tests: '

assert(type(class) == 'function', 'No existe la palabra clave class')
-- Testear si se pueden crear clases
assert(type(class 'NEWCLASS') == 'table', 'No se pueden crear clases')
-- Testear si se pueden instanciar clases
assert(type(class 'NEWCLASS':new()) == 'table', 'No se pueden instanciar clases')

io.stdout:write '[OK]'