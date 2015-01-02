require! 'gulp'
require! 'browser-sync'

module.exports = ($, options) ->

  gulp.task 'browser-sync', ->
    files = [
      'build/**/*.html'
      'build/css/**/*.css'
      'build/img/**/*'
      'build/js/**/*.js'
    ]

    browserSync do
      files: files
      server:
        baseDir: './build/'
