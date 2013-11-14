{TMuxTargetable} = require './targetable'

{commandRunnerFactory} = require './commands'


class OptionRegistry extends TMuxTargetable
  command: commandRunnerFactory()


class TmuxOptionRegistry extends OptionRegistry
  optionCommand: (method, key, value) =>
    method = method or ''
    key = key or ''
    value = value or ''

    contextArg = @asArgument @getContext()
    targetArg = @asArgument @getTarget()

    return "#{method}-option #{contextArg}#{targetArg}#{key} #{value}"

  set: (key, value) => @command @optionCommand 'set', key, value
  get: (key) => @command @optionCommand 'show', key


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
