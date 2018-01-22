require 'lide.base.init'

pruebasfile = lide.file.open 'pruebasfile'

content = 'lorem ipsum, quia dolor sit amet.'

assert(pruebasfile, 'It\'s not possible to open file.')
assert(pruebasfile:write(content))
assert(content == pruebasfile:read('*a'))