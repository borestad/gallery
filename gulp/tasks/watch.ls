require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'watch', ->

    # Templates
    gulp.watch 'src/templates/**/*.blade', ['blade']
    gulp.watch 'src/templates/**/*.jade', ['jade']

    # Static content
    gulp.watch 'src/htdocs/**/*.jade', ['htdocs']
    gulp.watch 'src/htdocs/**/*.{jpg,png,gif,css,html}', ['copy']

    # Styles
    gulp.watch 'src/styl/**/*.styl', ['stylus']
    #gulp.watch 'src/sass/**/*.{sass,scss}', ['sass']
    #gulp.watch 'src/lsass/**/*.{sass,scss}', ['libsass']

    # Vanilla JS
    gulp.watch 'src/js/**/*.js', ['browserify']

    # Images
    gulp.watch 'src/img/**/*.{jpg,png,gif}', ['imagemin']

    # The browserify task handles js recompiling with watchify
    # Outcomment these lines only for debugging
    # gulp.watch 'src/coffee/**/*.coffee', ['browserify']
    # gulp.watch 'src/ls/**/*.ls', ['browserify']

