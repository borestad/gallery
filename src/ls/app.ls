# foo = require './foo.ls'
# #templates = require '../../build/templates/foo'
j-template = require '../templates/j-index.jade'
# blade = require '../../node_modules/blade/index.js'

#b-template = require '../templates/b-index.blade'

# console.log foo
# console.log 'main.ls'
# console.log 'j-templates', j-template()

Ractive = require 'ractive'

ractive = new Ractive {
  el: '#output'
  template: require '../templates/template.html'
  data: {name: 'World'}
}

console.log 'app.ls!!'
console.log 'j-template', j-template!
#console.log 'b-template', b-template!
