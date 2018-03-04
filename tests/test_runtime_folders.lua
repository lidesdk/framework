#!/usr/bin/env lua5.1

-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/tests/test_runtime_folders.lua
-- // Purpose:   lide runtime folders test
-- // Created:   2018/03/04
-- // Copyright: (c) 2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

assert(app, 'test runtime: "app" value doesn\'t exists.')
assert(app.sourcefolder , 'test runtime folders: value app.sourcefolder doesn\'t exists.')
assert(app.workingfolder, 'test runtime folders: value app.workingfolder doesn\'t exists.')

print (('Source folder: %s'):format(app.sourcefolder))
print (('Working folder: %s'):format(app.workingfolder))