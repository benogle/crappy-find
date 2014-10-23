fs = require 'fs'
path = require 'path'

require.extensions['.html'] = (module, filePath) ->
  html = fs.readFileSync(filePath, 'utf8')
  tempDiv = document.createElement('div')
  tempDiv.innerHTML = html

  docFragment = document.createDocumentFragment()
  docFragment.appendChild(node) for node in Array::slice.call(tempDiv.childNodes, 0)
  module.exports = docFragment

registerElement = (elementName, elementPrototype) ->
  classToExtend = elementPrototype.extends ? HTMLElement
  prototype = Object.create(classToExtend.prototype)
  for key, value of elementPrototype
    prototype[key] = value if elementPrototype.hasOwnProperty(key)
  document.registerElement(elementName, {prototype})

class CrappyFindModel
  salutations: [
    { what: 'Hello', who: 'World' },
    { what: 'GoodBye', who: 'DOM APIs' },
    { what: 'Hello', who: 'Declarative' },
    { what: 'GoodBye', who: 'Imperative' }
  ]
  cats: 'ok'
  constructor: ->

Content = require('../templates/crappy-find.html')
CrappyFindElement = registerElement 'crappy-find',
  createdCallback: ->
    @rootTemplate = Content.querySelector('template').cloneNode(true)
    @appendChild(@rootTemplate)

  getModel: -> @model
  setModel: (@model) ->
    @rootTemplate?.model = @model

console.log CrappyFindElement
module.exports = {CrappyFindModel, CrappyFindElement}
