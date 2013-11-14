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

  describe '#server', ->
    it 'is an instance of Server', ->
      expect(XMX.server).to.be.instanceof Server

  # This is a bit meta, but I really want to keep it DRY.
  checkFactory = (Type, method) -> ->
    it "calls #{ Type.name }.factory", ->
      @sandbox.spy Type, 'factory'
      @sandbox.stub XMX, 'command', mockCommand

      result = XMX[method]()

      expect(XMX.command.calledOnce).to.equal true
      expect(Type.factory.calledOnce).to.equal true

  describe '#getClients', checkFactory Client, 'getClients'
  describe '#getSessions', checkFactory Session, 'getSessions'
  describe '#getWindows', checkFactory Window, 'getWindows'
  describe '#getPanes',  checkFactory Pane, 'getPanes'
