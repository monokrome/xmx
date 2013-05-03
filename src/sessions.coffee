{Base} = require './base'
{Window} = require './windows'

{objectFactory} = require './tmux'
{commandRunnerFactory} = require './commands'

expressions = require './expressions'

class Session extends Base
  initialize: =>
    @setupCommands()

  setupCommands: =>
    options =
      targetType: 'session'
      target: @identifier

    @command = commandRunnerFactory options, 'tmux'

  parseMatches: (matches) =>
    @identifier = matches[1]
    @windowCount = matches[2]
    @createdDate = matches[3]
    @columns = matches[4]
    @rows = matches[5]

    # Match 6 marks state as optional

    @state = matches[7]

  @factory: objectFactory Session

  getWindows: -> Window.factory @command 'list-windows'

module.exports = {
  Session
}

