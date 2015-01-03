require! 'gulp'
require! 'run-sequence'

module.exports = ($, options) ->

  gulp.task 'dist-app', ['dist-vendor', 'dist:app-js', 'dist:app-css']

  gulp.task 'dist:app-js', ->

    appFiles = ['./build/**/*.js', '!./build/**/vendor*.js']

    gulp.src appFiles
      # #.pipe $.concat 'app.concat.js'
      .pipe gulp.dest './dist/'
      .pipe $.sourcemaps.init!
      #.pipe $.uglify!
      # .pipe $.uglify {
      #   outSourceMap: true
      #   #sourceRoot: '../'
      #   output: {ascii_only: true}
      # }
      # .pipe $.rename (path) ->
      #   path.extname = ".min.js"
      #.pipe $.sourcemaps.write './'
      .pipe $.sourcemaps.write!
      .pipe gulp.dest './dist/'


  gulp.task 'dist:app-css', ->

    gulp.src './build/css/**/*.css'
      .pipe $.sourcemaps.init!
      .pipe $.minifyCss!
      #.pipe $.rename 'app.min.css'
      .pipe $.sourcemaps.write './'
      .pipe gulp.dest './dist/css'

  gulp.task 'dist-vendor', ->
    vendorFileList = [
      './build/vendor.min.js'
      './build/vendor.min.css'
      './build/vendor.min.js.map'
      './build/vendor.min.css.map'
    ]
    gulp.src vendorFileList
      .pipe gulp.dest './dist/'


  gulp.task 'dist-index', ->

    appFileList = [
      './dist/*.min.js'
      '!./dist/vendor.min.js'
      './dist/*.min.css'
      '!./dist/vendor.min.css'
    ]
    appFiles = gulp.src appFileList, {read: false}
    vendorFileList = ['./dist/vendor.min.js', './dist/vendor.min.css']
    vendorFiles = gulp.src vendorFileList, {read: false}

    gulp.src './build/index.html'
      .pipe $.inject vendorFiles, {
        ignorePath: '/dist/'
        starttag: '<!-- inject:vendor:{{ext}} -->'
        addRootSlash: false
      }
      .pipe $.inject appFiles, {
        ignorePath: '/dist/'
        addRootSlash: false
      }
      .pipe $.htmlmin options.htmlMinOptions
      .pipe gulp.dest './dist/'

  gulp.task 'dist', (cb) ->
    run-sequence do
      'flags:set-prod'
      'clean'
      'build'
      'dist-app'
      'dist-vendor'
      'dist-index',
      'serve:dist'
      #'deploy'

    cb
