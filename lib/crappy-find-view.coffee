fs = require 'fs'
path = require 'path'

class AtomElement extends HTMLElement
  @register: ->
    document.registerElement @::tagName, prototype: @::

  tagName: null
  templatePath: null
  createdCallback: ->
    if @templatePath?
      fs.readFile path.join(__dirname, @templatePath), (err, template) =>
        @loadTemplate(template.toString())

  attachedCallback: ->
  detachedCallback: ->
  attributeChangedCallback: (attrName, oldVal, newVal) ->

  getModel: -> @model
  setModel: (@model) ->
    @setModelOnTemplate()

  loadTemplate: (template) ->
    @innerHTML = template
    @setModelOnTemplate()

  setModelOnTemplate: ->
    firstChild = @childNodes[0]
    firstChild.model = @model if @model? and firstChild?.tagName is 'TEMPLATE'

class CrappyFindElement extends AtomElement
  tagName: 'crappy-find'
  templatePath: '../templates/crappy-find.html'

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
