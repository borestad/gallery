dest = "./build"
src = "./src"

module.exports =
  browserSync:
    server:
      # We're serving the src folder as well
      # for sass sourcemap linking
      baseDir: [
        dest
        src
      ]

    files: [
      dest + "/**"

      # Exclude Map files
      "!" + dest + "/**.map"
    ]

  sass:
    src: [
      "#{src}/sass/*.{sass,scss}",
      # Exclude vendor
      '!lib/sass/vendor',
      '!lib/sass/vendor/**'
      ]
    dest: dest
    settings:

      # Required if you want to use SASS syntax
      # See https://github.com/dlmanning/gulp-sass/issues/81
      sourceComments: "map"
      imagePath: "/images" # Used by the image-url helper

  stylus:
    src: 'src/styl/main-styl.styl'
    dest: dest
    settings:

      # Required if you want to use SASS syntax
      # See https://github.com/dlmanning/gulp-sass/issues/81
      sourceComments: "map"
      imagePath: "/images" # Used by the image-url helper


  images:
    src: "#{src}/images/**"
    dest: "#{src}/images"

  markup:
    src: "#{src}/htdocs/**"
    dest: dest

  browserify:
    # Enable source maps
    debug: true

    # Additional file extentions to make optional
    extensions: [
      ".coffee"
      ".hbs"
    ]

    # A separate bundle will be generated for each
    # bundle config in the list below
    bundleConfigs: [
      # {
      #   entries: src + "/javascript/app.coffee"
      #   dest: dest
      #   outputName: "app.js"
      # }
      # {
      #   entries: src + "/javascript/head.coffee"
      #   dest: dest
      #   outputName: "head.js"
      # }

      {
        entries      : ['./src/vendor/vendor.js']
        outputName : 'vendor.js'
        extensions : ['.js']
        dest       : './build/vendor'
      },
      {
        entries      : ['./src/js/app-js.js']
        outputName : 'app-js.js'
        extensions : ['.js']
        dest       : './build/js'
      },
      {
        entries      : ['./src/jst/blade-jst.coffee']
        outputName : 'blade-jst.js'
        extensions : ['.coffee']
        dest       : './build/jst'
      },
      {
        entries      : ['./src/coffee/app.coffee']
        outputName : 'app-coffee.js'
        extensions : ['.coffee']
        dest       : './build/js'
      },
      {
        entries      : ['./src/ls/app.ls']
        outputName : 'app-ls.js'
        extensions : ['.ls']
        dest       : './build/js'
      }

    ]
