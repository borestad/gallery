# Based on 1.0.0@alpha
# https://github.com/sindresorhus/gulp-ruby-sass/tree/rw/1.0

require! 'gulp'
filterByExtension = require '../util/filterByExtension'

module.exports = ($, options) ->

  gulp.task 'sass', ->
    dest = './build/css'

    cssFilter = filterByExtension 'css'

    $.ruby-sass options.src
    .on 'error', (err) ->
      console.error 'Error!', err.message

    #.pipe $.plumber!
    #.pipe $.changed(dest)
    # .pipe $.ruby-sass do
    #   sourcemapPath:
    #     sourcemap: true
    #     sourcemapPath: 'sass',
    #   # loadPath: [
    #     # process.cwd! + '/lib/sass'
    #     # process.cwd! + '/lib/sass/vendor'
    #     # process.cwd! + '/lib-core/sass'
    #   #] #
    # #}
    # # FIXME: Broken atm:
    # # https://github.com/sindresorhus/gulp-autoprefixer/issues/20
    # # .pipe $.autoprefixer 'last 2 version'
    # # .pipe filterByExtension 'css'
    # # .pipe $.if $.is-prod, $.pleeease(
    # #   minifier: true
    # #   sourcemaps: true
    # # )
    .pipe gulp.dest(dest)
