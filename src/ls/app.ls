# foo = require './foo.ls'
# #templates = require '../../build/templates/foo'
# j-template = require '../templates/j-index.jade'

# console.log foo
# console.log 'main.ls'
# console.log 'j-templates', j-template()

Ractive = require 'ractive'

ractive = new Ractive {
  el: '#output'
  template: require '../templates/template.html'
  data: {name: 'World'}
}
