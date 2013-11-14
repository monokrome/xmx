{Base} = require './base'
{Pane} = require './panes'

{objectFactory} = require './tmux'
{commandRunnerFactory} = require './commands'


class Window extends Base
  initialize: => @setupCommands()

  setupCommands: =>
    options =
      context: 'window'
      target: @identifier

    @command = commandRunnerFactory options, 'tmux'

  parseMatches: (matches) =>
    @identifier = matches[1]
    @name = matches[2]
    @paneCount = matches[3]

    @columns = matches[4]
    @rows = matches[5]

    @layout = matches[6]
    @index = matches[7]
    @state = matches[8]

  @factory: objectFactory Window

  getPanes: -> Pane.factory @command 'list-panes'


module.exports = {Window}
