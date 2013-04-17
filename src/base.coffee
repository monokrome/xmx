{EventEmitter} = require 'events'

class Base
  constructor: (options) ->
    options = options or {}

    if @parseOptions?
      @options = @parseOptions options
    else
      @options = options

    if @initialize? then  @initialize()

module.exports = {Base}

