require! 'gulp'
require! 'browser-sync'

module.exports = ($, options) ->

  gulp.task 'serve:dist', ->
    files = [
      'dist/**/*.html'
      'dist/**/*.css'
      'dist/img/**/*'
      'dist/**/*.js'
    ]

    browserSync do
      files: files
      server:
        baseDir: './dist/'
