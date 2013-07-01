{Base} = require './base'

class Targetable extends Base
  getTarget: -> throw new Error 'Targetable must be extended.'

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
  contextInheritance: [ 'server', 'session', 'window', 'pane' ]

  getContext: (command) =>
    if @options.context?
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

            if commandTypeIndex == (contextIndex + 1) or commandTypeIndex == contextIndex
              return ''

      return @contexts[@options.context] or @options.context

    return ''

  getTarget: =>
    if @options.targetType?
      flag = @contexts[@options.targetType] or @options.targetType
    else
      flag = ''

    if @options.target?
      flag = "#{flag} -t #{@options.target}"

    return flag

module.exports = {
  Targetable
  TMuxTargetable
}

