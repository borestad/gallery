require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'js', ->
    gulp.src 'src/js/**/*.js'
      .pipe $.plumber!
      .pipe $.concat 'main.js'
      #.pipe $.if $.is-prod, $.uglify!
      .pipe gulp.dest 'build/js'
