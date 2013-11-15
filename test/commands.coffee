{TmuxCommandRunner} = require '../src/commands'
{EventEmitter} = require 'events'
{expect} = require 'chai'

child_process = require 'child_process'
sinon = require 'sinon'


class MockProcess extends EventEmitter
  constructor: ->
    @stdout =
      on: ->

    @stdin =
      on: ->
      end: ->


describe 'TmuxCommandRunner', ->
  describe '#call', ->
    beforeEach ->
      @sandbox = sinon.sandbox.create()
      @runner = new TmuxCommandRunner

    afterEach ->
      @sandbox.restore()

    it 'should execute the given command via child_process#exec', ->
      exec = @sandbox.stub child_process, 'exec', -> new MockProcess

      @runner.call 'list-windows'

      expect(exec.calledOnce).to.be.true
      expect(exec.calledWith 'tmux list-windows').to.be.true
