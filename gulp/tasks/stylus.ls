require! 'gulp'
require! 'kouto-swiss'
require! 'rupture'
require! 'jeet'
prefixer = require 'autoprefixer-stylus'

module.exports = ($, options) ->
  use = [
    koutoSwiss!
    prefixer!
    jeet!
    rupture!
  ]

  # Based on
  # https://github.com/stevelacy/gulp-stylus/issues/73#issuecomment-54859244
  gulp.task "stylus", ->

    if $.is-dev
      return gulp.src(options.src)
        .pipe $.plumber!
        .pipe $.stylus {
          sourcemap: {
            inline: $.is-dev,
            sourceRoot: '..',
            basePath: 'css'
          }
          use: [
            koutoSwiss!
            prefixer!
            jeet!
            rupture!
          ]
          compress: true
        }
        .pipe gulp.dest 'build/css'



    if $.is-prod
      return gulp.src(options.src)
        .pipe $.plumber!
        .pipe $.stylus do
          sourcemap:
            inline: true
            sourceRoot: "."
            basePath: "css"
          use: use
        .pipe $.sourcemaps.init(loadMaps: true)
        .pipe $.pleeease(
          minifier: true
          sourcemaps: true
        )
        .pipe $.sourcemaps.write("./",
          includeContent: true
          sourceRoot: "."
        )
        .pipe gulp.dest("build/css")


