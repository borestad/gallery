require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'setWatch', ->
    global.isWatching = true
