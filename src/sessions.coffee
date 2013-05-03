{Base} = require './base'

{objectFactory} = require './tmux'

expressions = require './expressions'

class Session extends Base
  parseMatches: (matches) =>
    @identifier = matches[1]
    @windowCount = matches[2]
    @createdDate = matches[3]
    @columns = matches[4]
    @rows = matches[5]
    @state = matches[6]

  @factory: objectFactory Session

module.exports = {
  Session
}

