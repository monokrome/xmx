Q = require 'q'
{Base} = require './base'

expressions = require './expressions'

class Client extends Base

tmuxClientFactory = (promise) ->
  deferred = Q.defer()

  promise.done (rawData) ->
    clientData = rawData.split('\n').filter (line) -> line != ''
    clients = []

    for line in clientData
      matches = line.match expressions.tmux.clientsList

      # TODO: Log an error. This should never happen.
      if !matches then continue

      client = new Client

      client.tty = matches[1]
      client.identifier = matches[2]

      client.columns = matches[3]
      client.rows = matches[4]

      client.terminal = matches[6]
      client.encoding = matches[7]

      clients.push client

    deferred.resolve clients

  return deferred.promise

module.exports = {
  Client

  tmuxClientFactory
}

