require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'imagemin', ->
    dest = './build/img'

    gulp.src 'src/img/**/*'
      .pipe $.plumber!
      .pipe $.changed(dest)
      .pipe $.imagemin {
        optimizationLevel: 3
        progressive: true
        interlaced: true
      }
      .pipe gulp.dest(dest)
