{TMuxTargetable} = require './targetable'

{commandRunnerFactory} = require './commands'

class OptionRegistry extends TMuxTargetable
  command: commandRunnerFactory()

class TmuxOptionRegistry extends OptionRegistry
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

    @command "show-option #{key}"

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

