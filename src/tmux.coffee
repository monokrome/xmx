Q = require 'q'

expressions = require './expressions'

objectFactory = (objectType) ->
  return (promise) ->
    deferred = Q.defer()

    promise.done (rawData) ->
      objectData = rawData.split('\n').filter (line) -> line != ''
      objects = []

      for line in objectData
        objectName = objectType.name
        expression = expressions.tmux[objectName.toLowerCase() + 'sList']
        matches = line.match expression

        if not matches then continue

        object = new objectType

        if object.parseMatches?
          object.parseMatches matches
          object.setupCommands()

        objects.push object

      deferred.resolve objects

    return deferred.promise

module.exports = {
  objectFactory
}

