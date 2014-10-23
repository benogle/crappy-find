{CrappyFindModel, CrappyFindElement} = require './crappy-find-view'

global.Platform =
  performMicrotaskCheckpoint: ->
require 'Node-bind/src/NodeBind'
require 'TemplateBinding/src/TemplateBinding'
require 'observe-js'

module.exports =
  crappyFindView: null

  activate: (state) ->
    atom.workspace.addViewProvider
      modelConstructor: CrappyFindModel
      viewConstructor: CrappyFindElement

    @model = new CrappyFindModel
    @panel = atom.workspace.addBottomPanel item: @model

    atom.commands.add ".workspace", "crappy-find:toggle", =>
      if @panel.isVisible()
        @panel.hide()
      else
        @panel.show()

  deactivate: ->
    @crappyFindView.destroy()

  serialize: ->
    crappyFindViewState: @crappyFindView.serialize()
