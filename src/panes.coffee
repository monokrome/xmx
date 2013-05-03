{Base} = require './base'

{objectFactory} = require './tmux'

class Pane extends Base
  parseMatches: (matches) =>
    @identifier = matches[1]

    @columns = matches[2]
    @rows = matches[3]

    @history =
      size: matches[6]
      parts: [
        matches[4],
        matches[5]
      ]

    @index = matches[7]

    # 8 marks a segment as optional, so isn't used in parseMatches

    if matches.length > 9
      @state = matches[9]

  @factory: objectFactory Pane

module.exports = {
  Pane
}

