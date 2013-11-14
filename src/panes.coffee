{Base} = require './base'

{objectFactory} = require './tmux'
{commandRunnerFactory} = require './commands'


class Pane extends Base
  initialize: => @setupCommands()

  setupCommands: =>
    options =
      context: 'pane'
      target: @identifier

    @command = commandRunnerFactory options, 'tmux'

  parseMatches: (matches) =>
    @window = matches[2]
    @identifier = matches[3]

    @columns = matches[4]
    @rows = matches[5]

    @history =
      size: matches[8]
      parts: [
        matches[6],
        matches[7]
      ]

    @index = matches[9]

    # 10 marks a segment as optional, so isn't used in parseMatches

    if matches.length > 11
      @state = matches[11]

  @factory: objectFactory Pane


module.exports = {Pane}
