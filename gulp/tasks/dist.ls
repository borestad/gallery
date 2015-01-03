require! 'gulp'
require! 'run-sequence'

module.exports = ($, options) ->

  # browserify takes care of the uglify process when $.isProd == true
  gulp.task 'dist', ['dist:build']

  gulp.task 'dist:build', (cb) ->
    $.isProd = true

    run-sequence do
      'clean',
      ['blade', 'jade', 'htdocs', 'stylus','imagemin', 'browserify'],
      'sloc:build'
      cb

