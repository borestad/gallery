require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'flags:set-prod', ->
    $.is-prod = true
    $.is-dev = false

  gulp.task 'flags:set-watch', ->
    global.isWatching = true
