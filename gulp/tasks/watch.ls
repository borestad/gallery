require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'watch', ->
    gulp.watch 'src/templates/**/*.jade', ['jade']
    gulp.watch 'src/templates/**/*.blade', ['blade']
    gulp.watch 'src/styl/**/*.styl', ['stylus']
    gulp.watch 'src/js/**/*.js', ['js']
    gulp.watch 'src/img/**/*.{jpg,png,gif}', ['imagemin']
    gulp.watch 'src/htdocs/**/*.{jpg,png,gif,css,html}', ['copy']
    # The browserify task handles js recompiling with watchify
