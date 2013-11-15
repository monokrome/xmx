{XMX} = require '../src'
{checkFactory} = require './shortcuts'

{Client} = require '../src/clients'
{Window} = require '../src/windows'

sinon = require 'sinon'


describe 'Client', ->
  client = new Client

  beforeEach -> @sandbox = sinon.sandbox.create()
  afterEach -> @sandbox.restore()

  describe '#getWindows', checkFactory client, Window, 'getWindows'
