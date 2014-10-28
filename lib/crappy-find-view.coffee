fs = require 'fs'
path = require 'path'
{registerElement} = require 'elmer'

CrappyFindModel = require './crappy-find-model'
Template = require '../templates/crappy-find.html'

module.exports =
CrappyFindElement = registerElement 'crappy-find',
  modelConstructor: CrappyFindModel
  createdCallback: ->
    @appendChild(Template.clone())
    @rootTemplate = @querySelector('template')

    @input = @querySelector('atom-text-editor')
    @classList.add 'tool-panel', 'panel-bottom', 'padded'

    # atom.events.add this, 'button', 'click', -> @confirm()
    # atom.events.add this, 'core:confirm', -> @confirm()

  confirm: ->
    getCurrentEditor().scan(@input.value)

  getModel: -> @model
  setModel: (@model) ->
    @rootTemplate?.model = @model
