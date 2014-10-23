fs = require 'fs'
path = require 'path'

{Emitter} = require 'event-kit'
class ElementManager
  constructor: ->
    @emitter = new Emitter
    @templates = {}

  registerElement: (elementClass) ->
    @importTemplate(elementClass::templatePath) if elementClass::templatePath?
    document.registerElement elementClass::tagName, prototype: elementClass::

  observeTemplateForElement: (element, callback) ->
    id = element.tagName
    if @templates[id]?
      callback(@templates[id].cloneNode(true))
    else
      subscription = @emitter.on 'did-load-template', (template) ->
        subscription.dispose()
        callback(template.cloneNode(true))

  importTemplate: (templatePath) ->
    id = element.tagName
    return if @templates[id]?

    absolutePath = path.join(__dirname, templatePath)
    fs.readFile absolutePath, (err, templateContent) =>
      div = document.createElement('div') # yeah slop!
      div.innerHTML = templateContent.toString()
      template = div.querySelector('template')
      template.id = id
      document.head.appendChild(template)
      @templates[id] = template
      @emitter.emit 'did-load-template', template

atom.elements = new ElementManager


class CrappyFindModel
  salutations: [
    { what: 'Hello', who: 'World' },
    { what: 'GoodBye', who: 'DOM APIs' },
    { what: 'Hello', who: 'Declarative' },
    { what: 'GoodBye', who: 'Imperative' }
  ]
  cats: 'ok'
  constructor: ->

class CrappyFindElement extends HTMLElement
  tagName: 'crappy-find'
  templatePath: '../templates/crappy-find.html'

  createdCallback: ->
    console.log 'created!'
  attachedCallback: ->
    console.log 'attached!'
  detachedCallback: ->
    console.log 'detached!'

  getModel: -> @model
  setModel: (@model) ->
    atom.elements.observeTemplateForElement this, (template) =>
      @appendChild(template)
      template.model = @model

CrappyFindElement = atom.elements.registerElement(CrappyFindElement)

module.exports = {CrappyFindModel, CrappyFindElement}
