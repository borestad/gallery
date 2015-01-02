require! 'gulp'
require! 'run-sequence'

module.exports = ($, options) ->

  # browserify takes care of the uglify process when $.isProd == true
  $.isProd = true

  gulp.task 'dist', (cb) ->
    run-sequence do
      'clean',
      ['blade', 'jade', 'htdocs', 'stylus','imagemin', 'browserify'],
      cb

