require! 'gulp'
require! 'kouto-swiss'
require! 'rupture'
require! 'jeet'
prefixer = require 'autoprefixer-stylus'

module.exports = ($, options) ->

  gulp.task 'stylus', ->
    gulp.src 'src/styl/main.styl'
      .pipe $.plumber!
      .pipe $.bytediff.start!
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
        compress: $.is-prod
      }
      .pipe $.bytediff.stop!
      .pipe gulp.dest 'build/css'
