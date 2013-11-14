{TmuxOptionRegistry} = require '../src/options'
{expect} = require 'chai'
sinon = require 'sinon'


describe 'TmuxOptionRegistry', ->
  beforeEach ->
    @options = new TmuxOptionRegistry
    sinon.stub @options, 'command'

  describe '#set', ->
    it 'calls #command with the expected set-option command', ->
      command = 'set-option @testKey testValue'
      @options.set '@testKey', 'testValue'

      expect(@options.command.calledOnce).to.equal true
      expect(@options.command.calledWith command).to.equal true

    it 'calls #command with the expected show-option command', ->
      command = 'show-option @testKey'
      @options.get '@testKey'

      expect(@options.command.calledOnce).to.equal true
      expect(@options.command.calledWith command).to.equal true
