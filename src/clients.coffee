{Base} = require './base'

{objectFactory} = require './tmux'
{commandRunnerFactory} = require './commands'

class Client extends Base
  initialize: =>
    @setupCommands()

  setupCommands: =>
    options =
      target: @identifier

    @command = commandRunnerFactory options, 'tmux'

  parseMatches: (matches) =>
    @identifier = matches[1]
    @session = matches[2]

    @columns = matches[3]
    @rows = matches[4]

    @terminal = matches[6]
    @encoding = matches[7]

  @factory: objectFactory Client

module.exports = {
  Client
}

