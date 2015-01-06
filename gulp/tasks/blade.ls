module.exports = ($, options) ->

  require! 'gulp'

  # Blade templates
  gulp.task 'blade', ->
    gulp.src 'src/templates/**/*.blade'
      .pipe $.plumber!
      .pipe $.blade { middleware: true }
      .pipe gulp.dest 'build/templates'
