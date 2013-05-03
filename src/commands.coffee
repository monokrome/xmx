Q = require 'q'

{Base} = require './base'
{exec} = require 'child_process'

class CommandRunner extends Base
  translate: (command) -> command

  call: (command, end) =>
    deferred = Q.defer()
    output = ""

    process = exec @translate command

    process.stdout.on 'data', (data) -> output += data

    process.on 'close', (err) ->
      if err
        deferred.reject output 
      else
        deferred.resolve output

    if !end? or end == true then process.stdin.end()

    return deferred.promise

class TmuxCommandRunner extends CommandRunner
  translate: (command) -> "tmux #{command}"

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

