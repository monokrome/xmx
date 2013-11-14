{EventEmitter} = require 'events'


class Base
  constructor: (options) ->
    @options = options or {}

    if @initialize? then @initialize options


module.exports = {Base}
