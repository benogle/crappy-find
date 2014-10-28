CrappyFindModel = require './crappy-find-model'
CrappyFindElement = require './crappy-find-view'

module.exports =
  crappyFindView: null

  activate: (state) ->
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
