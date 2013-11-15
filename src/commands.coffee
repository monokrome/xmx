Q = require 'q'

{TMuxTargetable} = require './targetable'
child_process = require 'child_process'


# TODO: Make targetables generic.
class CommandRunner extends TMuxTargetable
  call: (command, end) =>
    deferred = Q.defer()
    output = new String

    if @translate?
      command = @translate command

    process = child_process.exec command
    process.stdout.on 'data', (data) -> output += data

    process.on 'close', (err) ->
      if err
        deferred.reject output
      else
        deferred.resolve output

    if !end? or end is true then process.stdin.end()
    return deferred.promise


class TmuxCommandRunner extends CommandRunner
  translate: (command) -> @asCommand [
    'tmux'

    @getTarget()
    @getContext command

    command
  ]


commandRunnerFactory = (options, type) ->
  options = options or {}

  type = type or 'tmux'
  className = type[0].toUpperCase() + type[1..] + 'CommandRunner'

  runner = new module.exports[className] options

  return runner.call


module.exports = {
  CommandRunner
  TmuxCommandRunner

  commandRunnerFactory
}
