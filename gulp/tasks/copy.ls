require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'copy', ->
    gulp.src ['src/htdocs/**/*.{jpg,png,gif,css,html}']
    .pipe gulp.dest 'build'
