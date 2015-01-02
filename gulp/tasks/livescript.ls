require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'ls', ->
    gulp.src 'src/ls/main.ls'
      .pipe $.livescript { bare: true }
      .on 'error', $.util.log
      .pipe gulp.dest './build/ls'
