require! 'gulp'
require! 'run-sequence'

module.exports = ($, options) ->

  gulp.task 'dist-app', ['dist:vendor', 'dist:js', 'dist:css']

  gulp.task 'dist:js', ->

    appFiles = ['./build/**/*.js', '!./build/**/vendor*.js']

    gulp.src appFiles
      # Copy files
      .pipe gulp.dest '.tmp'
      # Revision the files
      # .pipe $.rev-all!
      .pipe $.sourcemaps.init do
        loadMaps: true
      .pipe $.uglify!
      .pipe $.sourcemaps.write('./')
      .pipe gulp.dest './dist/'
      .pipe $.gzip!
      .pipe gulp.dest './dist/'
      .pipe $.rev-all.manifest { fileName: 'manifest.json' }
      .pipe $.rev-all.versionFile { fileName: 'version.json' }
      .pipe gulp.dest './dist/'


  gulp.task 'dist:css', ->
    gulp.src './build/css/**/*.{css,map}'
      #.pipe $.sourcemaps.init!
      #.pipe $.minifyCss!
      #.pipe $.rename 'app.min.css'
      #.pipe $.sourcemaps.write './'
      .pipe gulp.dest './dist/css'


  gulp.task 'dist:vendor', ->
    vendorFileList = [
      './build/vendor/vendor.*'
      './build/vendor/vendor.min.css'
      './build/vendor/vendor.min.js.map'
      './build/vendor/vendor.min.css.map'
    ]
    gulp.src vendorFileList
      .pipe gulp.dest './dist/vendor'


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
      #.pipe $.htmlmin options.htmlMinOptions
      .pipe gulp.dest './dist/'

  gulp.task 'dist', (cb) ->
    run-sequence do
      'flags:set-prod',
      'clean',
      'build',
      'dist-app',
      'dist:vendor',
      'dist-index',
      #'dist:cdn'
      'serve:dist'
      #'deploy'

    cb
