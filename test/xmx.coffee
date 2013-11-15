child_process = require 'child_process'

{XMX} = require '../src/index'

{Server} = require '../src/servers'
{Client} = require '../src/clients'
{Session} = require '../src/sessions'
{Window} = require '../src/windows'
{Pane} = require '../src/panes'

{checkFactory} = require './shortcuts'
{expect} = require 'chai'

sinon = require 'sinon'


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

  describe '#getSessions', checkFactory XMX, Session, 'getSessions'
  describe '#getClients', checkFactory XMX, Client, 'getClients'
  describe '#getWindows', checkFactory XMX, Window, 'getWindows'
  describe '#getPanes',  checkFactory XMX, Pane, 'getPanes'
