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
      input      : ['./src/jst/blade-jst.js']
      output     : 'blade-jst.js'
      extensions : ['.js']
      dest       : './build/jst'
    },
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
  getBundleName = ->
    pkg = require '../../package.json'
    version = pkg.version
    name = pkg.name
    version + '.' + name + '.' + 'min'

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

    # TODO: Allow brfs transforms
    # bundler.transform 'brfs'

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
        .pipe $.if $.is-prod, $.gzip!
        .pipe $.if $.is-prod, gulp.dest(options.dest)
        .on 'end', ->
          # Custom logging
          time = (new Date().getTime() - startTime) / 1000
          output = "#{options.dest}/#{options.output}"

          # Fixme: Cleanup
          path =
            raw:
              output: output

              #exists: fs.existsSync(output)
            # gzip:
            #   output: output + '.gzip'
            #   exists: fs.existsSync(output + '.gzip')

          stats = {}
          stats.raw = fs.statSync(path.raw.output)
          #stats.gzip = fs.statSync(path.gzip) if path.gzip.exists

          stats.raw.fileSizeInBytes = stats.raw.size
          stats.raw.fileSizeInKilobytes = stats.raw.fileSizeInBytes / 1000.0

          # if path.gzip.exists
          #   stats.gzip.fileSizeInBytes = stats.gzip.size
          #   stats.gzip.fileSizeInKilobytes = stats.gzip.fileSizeInBytes / 1000.0

          # FIXME: Only output this on successful builds
          actions = ['browserified']
          actions.push 'uglified' if $.is-prod
          actions.push 'gzipped' if $.is-prod #and path.gzip.exists
          actions = actions.join(' | ')

          msg = "✔  #{output.yellow} was [#{actions}]: #{(time + 's').magenta} | #{stats.raw.fileSizeInKilobytes} Kb"
          # if $.is-prod and path.gzip.exists
          #   msg += "\n✔  #{output.yellow} was [#{actions}]: #{(time + 's').magenta} | #{stats.gzip.fileSizeInKilobytes} Kb"

          $.util.log msg

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
