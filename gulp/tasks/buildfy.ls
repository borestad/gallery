require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'buildfy', [
    'browserify','blade','jade','stylus','imagemin','deploy'
  ]
