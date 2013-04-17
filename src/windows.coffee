Q = require 'q'
{Base} = require './base'

expressions = require './expressions'

class Window extends Base

tmuxWindowFactory = (promise) ->
  deferred = Q.defer()

  promise.then (rawData) ->
    windowData = rawData.split('\n').filter (line) -> line != ''
    windows = []

    for line in windowData
      matches = line.match expressions.tmux.windowsList

      if !matches then continue

      win = new Window

      win.identifier = matches[0]
      win.name = matches[1]
      win.paneCount = matches[2]

      win.columns = matches[3]
      win.rows = matches[4]

      win.layout = matches[5]
      win.index = matches[6]
      win.state = matches[7]

      windows.push win

    deferred.resolve windows

  return deferred.promise

module.exports = {
  Window

  tmuxWindowFactory
}

