require! 'gulp'
require! 'browserify'
require! 'watchify'

bundleLogger = require '../util/bundleLogger'
handleErrors = require '../util/handleErrors'
source = require 'vinyl-source-stream'
config = (require '../config').browserify

module.exports = ($, options) ->

  gulp.task 'watchify', ['flags:set-watch', 'browserify']

  gulp.task 'browserify', (callback) ->
    bundleQueue = config.bundleConfigs.length

    browserifyThis = (bundleConfig) ->
      bundler = browserify {
        cache: {}
        packageCache: {}
        fullPaths: true
        bundleConfig.entries
        config.extensions
        config.debug
      }

      bundler.transform 'coffeeify'
      bundler.transform 'liveify'
      bundler.transform 'jadeify'

      bundle = ->
        bundleLogger.start bundleConfig.outputName
        bundler.bundle!
          .on 'error', handleErrors
          .pipe source bundleConfig.outputName
          .pipe gulp.dest bundleConfig.dest
          .on 'end', reportFinished

      if global.isWatching
        bundler = watchify bundler
        bundler.on 'update', bundle

      reportFinished = ->
        bundleLogger.end bundleConfig.outputName
        if bundleQueue
          bundleQueue--
          callback! if bundleQueue is 0
      bundle!

    config.bundleConfigs.forEach browserifyThis
