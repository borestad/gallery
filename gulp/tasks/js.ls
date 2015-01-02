require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'js', ->
    gulp.src 'src/js/**/*.js'
      .pipe $.plumber!
      .pipe $.concat 'main.js'
      .pipe $.if $.isProd, $.uglify!
      .pipe gulp.dest 'build/js'
