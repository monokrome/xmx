Q = require 'q'
{Base} = require './base'

expressions = require './expressions'

class Pane extends Base

tmuxPaneFactory = (promise) ->
  deferred = Q.defer()

  promise.then (rawData) ->
    paneData = rawData.split('\n').filter (line) -> line != ''
    panes = []

    for line in paneData
      matches = line.match expressions.tmux.panesList

      if !matches then continue

      pane = new Pane

      pane.identifier = matches[1]

      pane.columns = matches[2]
      pane.rows = matches[3]

      pane.history =
        size: matches[6]
        parts: [
          matches[4],
          matches[5]
        ]

      pane.index = matches[7]

      # 8 marks a segment as optional

      if matches.length > 9
        pane.state = matches[9]

      panes.push pane

    deferred.resolve panes

  return deferred.promise

module.exports = {
  Pane

  tmuxPaneFactory
}


