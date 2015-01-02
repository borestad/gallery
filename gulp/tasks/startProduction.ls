require! 'gulp'
require! 'run-sequence'

module.exports = ($, options) ->

  gulp.task 'start:production', [
    'blade', 'jade', 'htdocs', 'stylus','imagemin', 'browserify', 'browser-sync'
  ]
