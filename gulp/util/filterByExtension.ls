filter = require 'gulp-filter'

module.exports = (extension) ->
  filter (file) ->
    file.path.match new RegExp '.' + extension + '$'
