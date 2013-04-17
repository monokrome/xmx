XMX
===

An extensible multiplexing expression library.


Installation
------------

Use npm. It's easy!

    npm install xmx


Usage
-----

Everything is based on using the XMX object from the 'xmx' module:

    XMX = require('xmx').XMX;

You can set/get global options using XMX.options.get and XMX.options.set
respetively. For instance, let's set a global free-form option called example:

    XMX.options.set('@example', 1);

You can get lists of clients, sessions, windows, or panes and some interesting
info about them like so:

    promise = XMX.getSessions();

    promise.done(function (sessions) {
        console.dir(sessions);
    });

You can read me about the promise library that XMX uses at
[it's GitHub page](https://github.com/kriskowal/q).

