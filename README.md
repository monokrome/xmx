XMX
===

An extensible multiplexing expression library.

Usage
-----

Everything is based on using the XMX object from the 'xmx' module:

    XMX = require('xmx').XMX


You can set/get global options using XMX.options.get and XMX.options.set
respetively. For instance, let's set a global free-form option called example:

    XMX.options.set('@example', 1)

