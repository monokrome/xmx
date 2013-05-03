{Base} = require './base'

{objectFactory} = require './tmux'

class Window extends Base
  parseMatches: (matches) =>
    @identifier = matches[0]
    @name = matches[1]
    @paneCount = matches[2]

    @columns = matches[3]
    @rows = matches[4]

    @layout = matches[5]
    @index = matches[6]
    @state = matches[7]

  @factory: objectFactory Window
    
module.exports = {
  Window
}

