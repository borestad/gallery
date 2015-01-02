require! 'gulp'

module.exports = ($, options) ->
  gulp.task 'build', [
    'js','jade','stylus','imagemin','deploy'
  ]
