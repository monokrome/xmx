{XMX} = require '../src'
{checkFactory} = require './shortcuts'

{Session} = require '../src/sessions'
{Window} = require '../src/windows'
{Pane} = require '../src/panes'

sinon = require 'sinon'


describe 'Session', ->
  session = new Session

  beforeEach -> @sandbox = sinon.sandbox.create()
  afterEach -> @sandbox.restore()

  describe '#getWindows', checkFactory session, Window, 'getWindows'
  describe '#getPanes', checkFactory session, Pane, 'getPanes'
