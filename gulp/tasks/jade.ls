require! 'gulp'

module.exports = ($, options) ->

  # Jade templates
  gulp.task 'jade', ->
    gulp.src 'src/templates/**/*.jade'
      .pipe $.plumber!
      .pipe $.jade { pretty: $.is-dev, client: true }
      .pipe gulp.dest 'build/templates'
