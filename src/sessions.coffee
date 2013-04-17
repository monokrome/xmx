Q = require 'q'
{Base} = require './base'

expressions = require './expressions'

class Session extends Base

tmuxSessionFactory = (promise) ->
  deferred = Q.defer()

  promise.then (rawData) ->
    sessionData = rawData.split('\n').filter (line) -> line != ''
    sessions = []

    for line in sessionData
      matches = line.match expressions.tmux.sessionsList

      if !matches then continue

      session = new Session

      session.identifier = matches[1]
      session.windowCount = matches[2]
      session.createdDate = matches[3]

      session.columns = matches[4]
      session.rows = matches[5]

      session.state = matches[6]

      sessions.push session

    deferred.resolve sessions

  return deferred.promise

module.exports = {
  Session

  tmuxSessionFactory
}

