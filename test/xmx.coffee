child_process = require 'child_process'

{XMX} = require '../src/index'
Q = require 'q'

{Server} = require '../src/servers'
{Client} = require '../src/clients'
{Session} = require '../src/sessions'
{Window} = require '../src/windows'
{Pane} = require '../src/panes'

{expect} = require 'chai'
sinon = require 'sinon'

fixtures = require './fixtures'


child_process.exec = -> throw new Error '''
  Attempted directly calling child_process.exec during a test
  without first wrapping it in a spy or a stub.
'''


describe 'XMX', ->
  # Set up sandbox
  beforeEach -> @sandbox = sinon.sandbox.create()
  afterEach -> @sandbox.restore()

  describe '#server', ->
    it 'is an instance of Server', ->
      expect(XMX.server).to.be.instanceof Server

  # This is a bit meta, but I really want to keep it DRY. The basic idea here
  # is that we're mocking the process used my CommandRunner to give us the
  # output from a command by providing fake output as a fixture.
  mockCommand = (fixture) ->
    deferred = Q.defer()

    resolve = -> deferred.resolve fixture
    setTimeout resolve, 0

    return -> deferred.promise

  checkFactory = (Type, method) -> ->
    it "calls #{ Type.name }.factory", (done) ->
      @sandbox.spy Type, 'factory'
      @sandbox.stub XMX, 'command', mockCommand fixtures[Type.name]

      result = XMX[method]()

      result.done (objects) ->
        expect(XMX.command.calledOnce).to.equal true
        expect(Type.factory.calledOnce).to.equal true

        done()

  describe '#getSessions', checkFactory Session, 'getSessions'
  describe '#getClients', checkFactory Client, 'getClients'
  describe '#getWindows', checkFactory Window, 'getWindows'
  describe '#getPanes',  checkFactory Pane, 'getPanes'
