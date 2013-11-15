{XMX} = require '../src'
{checkFactory} = require './shortcuts'

{Window} = require '../src/windows'
{Pane} = require '../src/panes'

sinon = require 'sinon'


describe 'Window', ->
  window = new Window

  beforeEach -> @sandbox = sinon.sandbox.create()
  afterEach -> @sandbox.restore()

  describe '#getPanes', checkFactory window, Pane, 'getPanes'
