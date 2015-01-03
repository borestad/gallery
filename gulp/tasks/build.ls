require! 'gulp'

module.exports = ($, options) ->
  gulp.task 'build', [
    'js', 'browserify', 'blade', 'jade', 'htdocs', 'stylus','imagemin'
  ]
