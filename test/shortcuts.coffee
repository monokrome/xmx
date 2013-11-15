Q = require 'q'
fixtures = require './fixtures'

{expect} = require 'chai'


# This is a bit meta, but I really want to keep it DRY. The basic idea here
# is that we're mocking the process used my CommandRunner to give us the
# output from a command by providing fake output as a fixture.
mockCommand = (fixture) ->
  deferred = Q.defer()

  resolve = -> deferred.resolve fixture
  setTimeout resolve, 0

  return -> deferred.promise

checkFactory = (root, Type, method) -> ->
  it "calls #{ Type.name }.factory", (done) ->
    @sandbox.spy Type, 'factory'
    @sandbox.stub root, 'command', mockCommand fixtures[Type.name]

    result = root[method]()

    result.done (objects) ->
      expect(root.command.calledOnce).to.equal true
      expect(Type.factory.calledOnce).to.equal true

      done()


module.exports = {mockCommand, checkFactory}
