require! 'gulp'

module.exports = ($, options) ->

  # Jade templates
  gulp.task 'htdocs', ->
    gulp.src 'src/htdocs/**/*.jade'
      .pipe $.plumber!
      .pipe $.jade { pretty: $.is-dev }
      .pipe gulp.dest 'build'

    gulp.src 'src/htdocs/**/*.blade'
      .pipe $.plumber!
      .pipe $.blade { middleware: true }
      .pipe gulp.dest 'build'
