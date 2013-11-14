{Base} = require './base'
{Window} = require './windows'

{commandRunnerFactory} = require './commands'
{objectFactory} = require './tmux'


class Client extends Base
  initialize: =>
    # Clients can be used interchangably with sessions
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

  getWindows: -> Window.factory @command 'list-windows'


module.exports = {Client}
