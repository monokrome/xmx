{Base} = require './base'

class Targetable extends Base
  getTarget: -> throw new Error 'Targetable must be extended.'

class TMuxTargetable extends Targetable
  contexts:
    session: '-s'
    window: '-w'
    pane: '-p'

  getContext: =>
    if @options.context?
      return @contexts[@options.context] or @options.context
    
    return ''

  getTarget: =>
    if @options.target?
      return "-t #{@options.target}"

    return ''


module.exports = {
  Targetable
  TMuxTargetable
}

