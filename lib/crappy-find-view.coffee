fs = require 'fs'
path = require 'path'

class AtomElement extends HTMLElement
  @tagName: null
  @register: ->
    document.registerElement @tagName, prototype: @::

  createdCallback: ->
  attachedCallback: ->
  detachedCallback: ->
  # attributeChangedCallback(attrName, oldVal, newVal)

  getModel: -> @model

{CompositeDisposable, Emitter} = require 'atom'
class CrappyFindElement extends HTMLElement
  @tagName: 'crappy-find'
  @register: ->
    document.registerElement @tagName, prototype: @::

  templatePath: path.join(__dirname, '../templates/crappy-find.html')
  createdCallback: ->
    fs.readFile @templatePath, (err, template) =>
      @loadTemplate(template.toString())

  loadTemplate: (template) ->
    @innerHTML = template
    @setModelOnTemplate()

  setModelOnTemplate: ->
    firstChild = @childNodes[0]
    firstChild.model = @model if @model? and firstChild?.tagName is 'TEMPLATE'

  getModel: -> @model
  setModel: (@model) ->
    @setModelOnTemplate()

class CrappyFindModel
  salutations: [
    { what: 'Hello', who: 'World' },
    { what: 'GoodBye', who: 'DOM APIs' },
    { what: 'Hello', who: 'Declarative' },
    { what: 'GoodBye', who: 'Imperative' }
  ]

  constructor: ->

CrappyFindElement = CrappyFindElement.register()
module.exports = {CrappyFindModel, CrappyFindElement}
