require! 'gulp'
require! 'run-sequence'

module.exports = ($, options) ->

  gulp.task 'start:development', [
    'watchify','blade', 'jade', 'htdocs', 'stylus','imagemin','watchfy','browser-sync'
  ]
