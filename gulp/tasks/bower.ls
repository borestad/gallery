require! 'gulp'
mainBowerFiles = require 'main-bower-files'
filterByExtension = require '../util/filterByExtension'


# Based on great ideas from here:
# http://engineroom.teamwork.com/hassle-free-third-party-dependencies/

module.exports = ($, options) ->

  gulp.task 'bower', ->
    mainFiles = mainBowerFiles!
    return if not mainFiles.length
    jsFilter = filterByExtension 'js'

    gulp.src mainFiles
      .pipe jsFilter
      .pipe $.concat 'vendor-bower.js'
      .pipe gulp.dest './build/vendor'
      .pipe jsFilter.restore!
      .pipe filterByExtension 'css'
      .pipe $.concat 'vendor-bower.css'
      .pipe gulp.dest './build/vendor'
