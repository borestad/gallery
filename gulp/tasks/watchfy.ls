require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'watchfy', ->
    gulp.watch 'src/templates/**/*.blade', ['blade']
    gulp.watch 'src/templates/**/*.jade', ['jade']
    gulp.watch 'src/htdocs/**/*.jade', ['htdocs']
    gulp.watch 'src/styl/**/*.styl', ['stylus']
    gulp.watch 'src/js/**/*.js', ['browserify']
    gulp.watch 'src/coffee/**/*.coffee', ['browserify']
    gulp.watch 'src/ls/**/*.ls', ['browserify']
    gulp.watch 'src/img/**/*.{jpg,png,gif}', ['imagemin']
