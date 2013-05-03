Q = require 'q'

{TMuxTargetable} = require './targetable'
{exec} = require 'child_process'

# TODO: Make targetables generic.
class CommandRunner extends TMuxTargetable
  translate: (command) -> command

  call: (command, end) =>
    deferred = Q.defer()
    output = ""

    translatedCommand = @translate command
    process = exec translatedCommand

    process.stdout.on 'data', (data) -> output += data

    process.on 'close', (err) ->
      if err
        deferred.reject output 
      else
        deferred.resolve output

    if !end? or end == true then process.stdin.end()

    return deferred.promise

class TmuxCommandRunner extends CommandRunner
  translate: (command) ->
    result = "tmux #{command} #{@getContext()} #{@getTarget()}"

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

