require! 'gulp'
require! 'kouto-swiss'
require! 'rupture'
require! 'jeet'
prefixer = require 'autoprefixer-stylus'

module.exports = ($, options) ->

  gulp.task 'stylus', ->
    gulp.src 'src/styl/main.styl'
      .pipe $.plumber!
      .pipe $.stylus {
        sourcemap: {
          inline: true,
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
      .pipe gulp.dest 'build/css'
