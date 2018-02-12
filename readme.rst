Lide Framework
==============

Lide Framework is a library that allows you to create multiplatform 
graphical interfaces from Lua language.
Lide uses wxWidgets to build controls and windows, this ensures the 
integration of your applications with GTK+ on Linux and really native 
controls in Windows.


========================================================= ==================================================================================
 git branch: ``develop``                                   build status
========================================================= ==================================================================================
 Tests executed in **Windows 10** x64 and x86 machines      .. image:: https://ci.appveyor.com/api/projects/status/kqs9p85067nqtg5b/branch/develop?svg=true
                                                               :target: https://ci.appveyor.com/project/dcanoh/framework/branch/develop
 Tests executed in **Ubuntu 14.04** Trusty x64 machine      .. image:: https://circleci.com/gh/lidesdk/framework/tree/develop.svg?style=svg
                                                               :target: https://circleci.com/gh/lidesdk/framework/tree/develop
========================================================= ==================================================================================

Installation
============

First install lide shell from github:

.. code-block:: bash

	$ mkdir lide
	$ cd lide
	$ git clone https://github.com/lidesdk/shell.git --recursive

* If you don't have git installed on your system you can download the
  last version of lide shell installer: `from here <https://github.com/lidesdk/shell/releases>`_.


Luarocks Installation
=====================

If you have luarocks installed in your machine:

.. code-block:: bash
	$ luarocks install luafilesystem
	$ luarocks install https://raw.githubusercontent.com/lidesdk/framework/master/lide-0.1.rockspec --local


How to use it
=============

* Create a file ``main.lua`` into the folder ``lide_app``.

.. code-block:: bash
	$ mkdir lide_app && cd lide_app
	$ nano main.lua

.. code-block:: lua
	
	lide = require 'lide.widgets.init'

	local Form   = lide.classes.widgets.form
	local Button = lide.classes.widgets.button

	local MessageBox = lide.core.base.messagebox

	form1 = Form:new { Name = 'form1',
		Title = 'Window Caption'
	};

	button1 = Button:new { Name = 'button1', Parent = form1,
		PosX = 10, PosY = 30, Text = 'Click me!',
	};

	button1.onClick : setHandler ( function ( event )
		lide.widgets.messagebox 'Hello world!'
	end );

	form1:show(true);


With the above code we are creating a new form and putting a button 
inside it at position (10, 30), clicking inside the button a message 
"Hello World" is displayed.

* Run the file ``main.lua`` with the following command:

.. code-block:: bash
	
	$ lua5.1 -l lide.init main.lua

This is all you need to start building applications, **should be noted
that these instructions work** similarly to Windows or GNU/Linux.



Help & Documentation
====================

If you want to know more please read our official framework's 
documentation:

`- Lide Framework readthedocs <http://lide-framework.rtfd.io>`_


Credits and Authors
===================

Lide was founded in 2014 by Hernán D. Cano (`@dcanoh <https://github.com/dcanoh>`_) 
and Jesús H. Cano (`@jhernancanom <https://github.com/jhernancanom>`_ ) 
for private purposes, today is accessible to the public.

Lide is currently active and developing, today is maintained by (`@dcanoh <https://github.com/dcanoh>`_).


License
=======

Lide is licensed under (`The GNU General Public License <https://github.com/lidesdk/commandline/blob/master/LICENSE>`_). Copyright © 2018 Hernán Dario Cano.