{Base} = require './base'
{exec} = require 'child_process'

class CommandRunner extends Base
  translate: (command) -> command

  call: (command, end) =>
    process = exec @translate command

    if !end? or end == true then process.stdin.end()

    return process

class TmuxCommandRunner extends CommandRunner
  translate: (command) -> "tmux #{command}"

commandRunnerFactory = (options, type) ->
  options = options or {}

  type = type or 'tmux'
  className = type[0].toUpperCase() + type[1..] + 'CommandRunner'

  runner = new module.exports[className] options

  runner.call

module.exports = {
  CommandRunner
  TmuxCommandRunner

  commandRunnerFactory
}

