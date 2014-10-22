{WorkspaceView} = require 'atom'
CrappyFind = require '../lib/crappy-find'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "CrappyFind", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('crappy-find')

  describe "when the crappy-find:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.crappy-find')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'crappy-find:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.crappy-find')).toExist()
        atom.workspaceView.trigger 'crappy-find:toggle'
        expect(atom.workspaceView.find('.crappy-find')).not.toExist()
