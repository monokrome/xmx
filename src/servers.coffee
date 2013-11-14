{Base} = require './base'
{Client} = require './clients'
{Session} = require './sessions'
{Window} = require './windows'
{Pane} = require './panes'

{objectFactory} = require './tmux'
{commandRunnerFactory} = require './commands'


class Server extends Base
  initialize: => @setupCommands()

  setupCommands: =>
    options =
      context: 'server'

    @command = commandRunnerFactory options, 'tmux'

  getClients: -> Client.factory @command 'list-clients'
  getSessions: -> Session.factory @command 'list-sessions'
  getWindows: -> Window.factory @command 'list-windows'
  getPanes: -> Pane.factory @command 'list-panes'


module.exports = {Server}
