{Base} = require './base'


class Targetable extends Base
  getTarget: -> throw new Error 'Targetable must be extended.'

  asArgument: (argument) ->
    return '' unless argument? and argument.length > 0
    return argument


class TMuxTargetable extends Targetable
  contexts:
    server: '-a'
    session: '-s'
    window: '-w'
    pane: '-p'

  # This is required because tmux has a silly way of not providing options to
  # specifically ask for context on "nearest-neighbor' context types. As one
  # example, `tmux list-windows` doesn't take a -s argument, even though
  # `tmux list-panes` does - and windows are inside of sessions. The assumed
  # defaults can not be provided for no good reason.
  contextInheritance: [ 'server', 'client', 'session', 'window', 'pane' ]

  getContext: (command) =>
    if @options.context? and @options.context isnt 'client'
      # This is a hack which solves the earlier mentioned tmux issue where
      # nearest-neighbor contexts aren't allowed to be passed as contexts
      if command?
        baseCommand = command.split ' '

        if baseCommand.length
          pluralCommandType = baseCommand[0].split '-'

          if pluralCommandType.length > 1
            commandType = pluralCommandType[1..(pluralCommandType.length-1)][0]
            commandTypeLastIndex = commandType.length - 1

            # Removed s at the end of pluralized commands
            if commandType[commandTypeLastIndex] == 's'
              commandType = commandType[0..commandTypeLastIndex-1]

            # Check if this is the nearest neighbor type, and return an
            # empty string if so - due to our context already being the default
            # behavior.
            contextIndex = @contextInheritance.indexOf @options.context
            commandTypeIndex = @contextInheritance.indexOf commandType

            return '' if commandTypeIndex == (contextIndex + 1)
            return '' if commandTypeIndex == contextIndex

      return @contexts[@options.context] or @options.context

    return ''

  getTarget: =>
    flags = []

    if @options.targetType?
      flags.push @contexts[@options.targetType] or @options.targetType

    if @options.target?
      flags.push '-t ' + @options.target

    return flags.join ' '


module.exports = {
  Targetable
  TMuxTargetable
}
