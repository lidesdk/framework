#!/usr/bin/env lua5.1

-- load only core lua framework without classes
local lide = require 'lide.core.init'

-- Testear si existe la palabra clave 'class'
assert(type(class) == 'function', 'No existe la palabra clave class')
-- Testear si se pueden crear clases
assert(type(class 'NEWCLASS') == 'table', 'No se pueden crer clases')
-- Testear si se pueden instanciar clases
assert(type(class 'NEWCLASS':new()) == 'table', 'No se pueden instanciar clases')

---
--- TODO: load wxlua library in travisci and execute these texts:
---
---
-- local lide_classes_controls = { 'textctrl', 'label', 'progress', 'toolbar', 'grid', 'image', 'button', 'textbox', 'htmlview', 'listbox', 'combobox' }
-- local lide_classes_widgets  = { 'panel', 'window', 'form', 'control' }
-- 
-- for _, class_name in pairs( lide_classes_controls ) do
--   assert(type(lide.classes.controls[class_name]) == 'table', 'No se pudo cargar la clase "lide.classes.controls.' ..class_name..'"')
-- end
-- 
-- for _, class_name in pairs( lide_classes_widgets ) do
--   assert(type(lide.classes.widgets [class_name]) == 'table', 'No se pudo cargar la clase "lide.classes.widgets.'  ..class_name..'"')
-- end