{XMX} = require '../src'
{checkFactory} = require './shortcuts'

{Client} = require '../src/clients'
{Session} = require '../src/sessions'
{Window} = require '../src/windows'
{Pane} = require '../src/panes'

sinon = require 'sinon'


describe 'Server', ->
  beforeEach -> @sandbox = sinon.sandbox.create()
  afterEach -> @sandbox.restore()

  describe '#getClients', checkFactory XMX.server, Client, 'getClients'
  describe '#getSessions', checkFactory XMX.server, Session, 'getSessions'
  describe '#getWindows', checkFactory XMX.server, Window, 'getWindows'
  describe '#getPanes', checkFactory XMX.server, Pane, 'getPanes'
