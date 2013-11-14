{Server} = require './servers'
{Client} = require './clients'
{Session} = require './sessions'
{Window} = require './windows'
{Pane} = require './panes'

{commandRunnerFactory} = require './commands'
{optionRegistryFactory} = require './options'


# TODO: Support command mode when instantiated
class XMX
  @command: commandRunnerFactory {}, 'tmux'
  @options: optionRegistryFactory {}, 'tmux'

  @server: new Server

  @getClients: => Client.factory @command 'list-clients'
  @getSessions: => Session.factory @command 'list-sessions'
  @getWindows: => Window.factory @command 'list-windows'
  @getPanes: => Pane.factory @command 'list-panes'


module.exports = {XMX}

