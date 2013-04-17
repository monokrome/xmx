{commandRunnerFactory} = require './commands'
{optionRegistryFactory} = require './options'

{tmuxClientFactory} = require './clients'
{tmuxSessionFactory} = require './sessions'
{tmuxWindowFactory} = require './windows'
{tmuxPaneFactory} = require './panes'

# TODO: Support command mode when instantiated
class XMX
  @command: commandRunnerFactory({}, 'tmux')
  @options: optionRegistryFactory({}, 'tmux')

  @getClients: => tmuxClientFactory @command 'list-clients'
  @getSessions: => tmuxSessionFactory @command 'list-sessions'
  @getWindows: => tmuxWindowFactory @command 'list-windows'
  @getPanes: => tmuxPaneFactory @command 'list-panes'

module.exports = {XMX}

