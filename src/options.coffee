{TMuxTargetable} = require './targetable'
{commandRunnerFactory} = require './commands'

_ = require 'lodash'


class OptionRegistry extends TMuxTargetable
  command: commandRunnerFactory()


class TmuxOptionRegistry extends OptionRegistry
  optionCommand: (method, key, value) =>
    method = method or ''
    key = key or ''
    value = value or ''

    args = [
      @getContext()
      @getTarget()
      key
      value
    ].map @asArgument

    args = args.reduce (left, right) ->
      return right if left.length is 0
      return left if right.length is 0
      return left + ' ' + right

    return method + '-option ' + args

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
