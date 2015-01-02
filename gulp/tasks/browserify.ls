require! 'gulp'
require! 'browserify'
require! 'watchify'
require! 'jadeify'
require! 'fs'
require! 'colors'
_ = require 'lodash'
source = require 'vinyl-source-stream'

module.exports = ($, config) ->

  files = [
    {
      input      : ['./src/coffee/app.coffee']
      output     : 'app-coffee.js'
      extensions : ['.coffee']
      dest       : './build/js'
    },
    {
      input      : ['./src/ls/app.ls']
      output     : 'app-ls.js'
      extensions : ['.ls']
      dest       : './build/js'
    }
  ]

  createBundle = (options) ->
    if global.isWatching
      for input in options.input
        $.util.log "Using Watchify for #{input.yellow}"

      bundler = watchify(
        browserify(
          entries: options.input
          #cache: {}
          #packageCache: {}
          debug: true
        ),
        watchify.args
      )

    else
      for input in options.input
        $.util.log "Using Browserify for #{input.yellow}"

      bundler = browserify do
        entries   : options.input
        extensions: options.extensions

    bundler.transform 'coffeeify'
    bundler.transform 'liveify'
    bundler.transform 'jadeify'

    rebundle = ->
      startTime = new Date().getTime()
      bundler.bundle!
        .on 'error', $.util.log.bind $.util, "[Browserify error]".red + "\n"
        .on 'error', $.notify.onError(
          title: "Compile Error",
          message: "<%= error.message %>"
        )
        .pipe source(options.output)
        .pipe $.if $.is-prod, $.streamify($.uglify {outSourceMap: true})
        .pipe gulp.dest(options.dest)
        .on 'end', ->
          time = (new Date().getTime() - startTime) / 1000
          output = "#{options.dest}/#{options.output}"
          stats = fs.statSync(output)
          fileSizeInBytes = stats.size
          fileSizeInKilobytes = fileSizeInBytes / 1000.0
          # FIXME: Only output this on successful builds
          $.util.log "✔  #{output.yellow} was browserified: #{(time + 's').magenta} | #{fileSizeInKilobytes} Kb"

    if global.isWatching
      bundler.on 'update', rebundle

    rebundle()


  createBundles = (bundles) ->
    bundles.forEach (bundle) ->
      createBundle do
        input      : bundle.input
        output     : bundle.output
        extensions : bundle.extensions
        dest       : bundle.dest


  gulp.task 'watchify', _.once ->
    global.isWatching = true
    createBundles files

  gulp.task 'browserify', ->
    global.isWatching = false
    createBundles files
