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


child_process.exec = -> throw new Error '''
  Attempted directly calling child_process.exec during a test
  without first wrapping it in a spy or a stub.
'''


describe 'XMX', ->
  mockCommand = -> Q.defer().promise

  # Set up sandbox
  beforeEach -> @sandbox = sinon.sandbox.create()
  afterEach -> @sandbox.restore()

  # This is a bit meta, but I really want to keep it DRY.
  checkFactory = (Type, method) -> ->
    @sandbox.spy Type, 'factory'
    @sandbox.stub XMX, 'command', mockCommand

    result = XMX[method]()

    expect(XMX.command.calledOnce).to.equal true
    expect(Type.factory.calledOnce).to.equal true

  describe '#server', ->
    it 'is an instance of Server', ->
      expect(XMX.server).to.be.instanceof Server

  describe '#getClients', ->
    it 'calls Client.factory', checkFactory Client, 'getClients'

  describe '#getSessions', ->
    it 'calls Session.factory', checkFactory Session, 'getSessions'

  describe '#getWindows', ->
    it 'calls Window.factory', checkFactory Window, 'getWindows'

  describe '#getPanes', ->
    it 'calls Pane.factory', checkFactory Pane, 'getPanes'
