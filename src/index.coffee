{commandRunnerFactory} = require './commands'
{optionRegistryFactory} = require './options'

# TODO: Support command mode when instantiated
class XMX
  @command = commandRunnerFactory {}, 'tmux'
  @options = optionRegistryFactory {}, 'tmux'

module.exports = {XMX}

