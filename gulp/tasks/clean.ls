# https://github.com/gulpjs/gulp/blob/master/docs/recipes/delete-files-folder.md
require! 'gulp'
require! 'browser-sync'
require! 'del'

module.exports = ($, options) ->

  gulp.task 'clean', ['clean:tmp', 'clean:build', 'clean:dist']

  gulp.task 'clean:tmp', (cb) ->
    files = ['.tmp/**/*']
    del files, cb

  gulp.task 'clean:build', (cb) ->
    files = ['build/**/*']
    del files, cb

  gulp.task 'clean:dist', (cb) ->
    files = ['dist/**/*']
    del files, cb
