{Base} = require './base'

{commandRunnerFactory} = require './commands'

class OptionRegistry extends Base
  command: commandRunnerFactory()


class TmuxOptionRegistry extends OptionRegistry
  contexts =
    window: '-w'
    session: '-s'
    pane: '-p'

  getContext: =>
    if @options.context?
      return @contexts[@option.context] or @options.context
    
    return ''

  getTarget: =>
    if @options.targetType?
      flag = "#{@getContext()}"

      if @options.target?
        flag = "#{flag} #{@options.target}"

      return flag

    return ''

  optionCommand: (method, key, value) =>
    method = method or ''
    key = key or ''
    value = value or ''

    return "#{method}-option #{@getContext()} #{@getTarget()} #{key} #{value}"

  set: (key, value) =>
    commandString = @optionCommand 'set', key, value

    @command commandString

  get: (key) =>
    commandString = @optionCommand 'show', key

    @comand "show-option #{key} #{value}"

optionRegistryFactory = (options, type) ->
  options = options or {}

  type = type or 'tmux'
  className = type[0].toUpperCase() + type[1..] + 'OptionRegistry'

  return new module.exports[className] options

module.exports = {
  OptionRegistry
  TmuxOptionRegistry

  optionRegistryFactory
}

