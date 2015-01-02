require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'default',
    [if $.isDev then 'start:development' else 'start:production']
