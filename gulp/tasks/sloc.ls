require! 'gulp'

module.exports = ($, options) ->

  # Jade templates
  gulp.task 'sloc', ['sloc:build']

  gulp.task 'sloc:build', ->
    gulp.src 'build/**/*.js'
      .pipe $.sloc!

  gulp.task 'sloc:dist', ->
    gulp.src 'dist/**/*.js'
      .pipe $.sloc!
