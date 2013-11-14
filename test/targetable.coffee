{TMuxTargetable} = require '../src/targetable'
{expect} = require 'chai'
sinon = require 'sinon'

describe 'TMuxTargetable', ->
  describe '#getContext', ->
    it 'returns an empty string without a context', ->
      targetable = new TMuxTargetable
      expect(targetable.getContext()).to.equal ''

    it 'returns expected values with a server context', ->
      targetable = new TMuxTargetable
        context: 'server'

      expect(targetable.getContext 'list-windows').to.equal '-a'
      expect(targetable.getContext 'list-panes').to.equal '-a'

    it 'returns expected values with a session context', ->
      targetable = new TMuxTargetable
        context: 'session'

      expect(targetable.getContext 'list-windows').to.equal ''
      expect(targetable.getContext 'list-panes').to.equal '-s'

    it 'returns expected values with a window context', ->
      targetable = new TMuxTargetable
        context: 'window'

      expect(targetable.getContext 'list-windows').to.equal ''
      expect(targetable.getContext 'list-panes').to.equal ''

    it 'returns expected values with a pane context', ->
      targetable = new TMuxTargetable
        context: 'pane'

      expect(targetable.getContext 'list-windows').to.equal '-p'
      expect(targetable.getContext 'list-panes').to.equal ''
