{TmuxCommandRunner} = require '../src/commands'
{EventEmitter} = require 'events'
{expect} = require 'chai'

child_process = require 'child_process'
sinon = require 'sinon'


class MockProcess extends EventEmitter
  constructor: (error) ->
    emitEvents = =>
      @emit 'close', error

    @stdout =
      on: ->

    @stdin =
      on: ->
      end: ->

    setTimeout emitEvents, 100

describe 'TmuxCommandRunner', ->
  describe '#call', ->
    beforeEach ->
      @sandbox = sinon.sandbox.create()
      @runner = new TmuxCommandRunner

    afterEach ->
      @sandbox.restore()

    it 'should execute the given command via child_process#exec', (done) ->
      exec = @sandbox.stub child_process, 'exec', -> new MockProcess
      promise = @runner.call 'list-windows'

      promise.done (data) ->
        expect(exec.calledOnce).to.be.true
        expect(exec.calledWith 'tmux list-windows').to.be.true

        done()
