fs = require 'fs'
path = require 'path'

class AtomElement extends HTMLElement
  @register: ->
    document.registerElement @::tagName, prototype: @::

  tagName: null
  templatePath: null
  createdCallback: ->
    @importTemplate(@templatePath) if @templatePath?

  attachedCallback: ->
  detachedCallback: ->
  attributeChangedCallback: (attrName, oldVal, newVal) ->

  idify: (str) ->
    str.replace(/[^a-zA-Z0-9]/g, '-')

  importTemplate: (templatePath) ->
    absolutePath = path.join(__dirname, templatePath)
    id = @idify(absolutePath)
    link = document.head.querySelector("##{id}")
    if link?
      @cloneTemplate(link)
    else
      fs.readFile absolutePath, (err, templateContent) =>
        div = document.createElement('div') # yeah slop!
        div.innerHTML = templateContent.toString()
        template = div.querySelector('template')
        template.id = id
        document.head.appendChild(template)
        @cloneTemplate(template)

  # FIXME: the 'right' way to do the import. But it messes up char measurement.
  # When you add the import to the docuemnt, it seems to hide everything just as
  # the characters are being mesured, giving a 0 width for each char.
  #
  # importTemplate: (templatePath) ->
  #   absolutePath = path.join(__dirname, templatePath)
  #   id = @idify(absolutePath)
  #   link = document.head.querySelector("##{id}")
  #   if link?
  #     @cloneTemplate(link.import)
  #   else
  #     link = document.createElement('link')
  #     link.rel = 'import'
  #     link.id = id
  #     link.href = absolutePath
  #     link.async = true
  #     link.onload = (e) => @cloneTemplate(e.target.import)
  #     document.head.appendChild(link)

  getModel: -> @model
  setModel: (@model) ->
    @setModelOnTemplate()

  cloneTemplate: (templateRoot) ->
    template = templateRoot.cloneNode(true)
    @appendChild(template)
    @setModelOnTemplate()

  setModelOnTemplate: ->
    return unless @model?
    return unless template = @querySelector('template')
    template.model = @model

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
  cats: 'ok'

  constructor: ->

CrappyFindElement = CrappyFindElement.register()
module.exports = {CrappyFindModel, CrappyFindElement}
