{Base} = require './base'

{objectFactory} = require './tmux'

class Client extends Base
  parseMatches: (matches) =>
    @tty = matches[1]
    @identifier = matches[2]

    @columns = matches[3]
    @rows = matches[4]

    @terminal = matches[6]
    @encoding = matches[7]

  @factory: objectFactory Client

module.exports = {
  Client
}

