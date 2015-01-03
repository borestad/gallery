require! 'gulp'
require! 'run-sequence'

module.exports = ($, options) ->

  # browserify takes care of the uglify process when $.isProd == true
  gulp.task 'dist', ['dist:compile']

  gulp.task 'dist:copy-from-build', ->
    gulp.src(["build/**/*"], {base: "./build"})
        .pipe(gulp.dest("dist/"))

    # gulp.src 'build/*', {base: "."}
    # gulp.dest 'dist/'

  gulp.task 'dist:compile', (cb) ->
    $.isProd = true

    run-sequence do
      'clean',
      ['blade', 'jade', 'htdocs', 'stylus','imagemin', 'browserify'],
      'dist:copy-from-build'
      #'dist:revision'
      cb


  gulp.task 'dist:revision', (cb) ->
