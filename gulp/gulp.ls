# Readme:
# https://github.com/floridoo/gulp-sourcemaps/wiki/Plugins-with-gulp-sourcemaps-support
# https://github.com/mod-ui/mod-gulp/blob/master/main.ls
# https://github.com/m4n3z40/nextgen-stater-project/blob/master/gulpfile.js

# For development => gulp
# For production  => gulp -p
env         = (require 'minimist') process.argv.slice 2
$           = (require 'gulp-load-plugins') {lazy: true}
$.is-prod    = !!env.p
$.isDev     = not $.is-prod

buffer      = require 'vinyl-buffer'
coffeeify   = require 'coffeeify'
colors      = require 'colors'
fs          = require 'fs'
gulp        = require 'gulp'
liveify     = require 'liveify'
modRewrite  = require 'connect-modrewrite'
rsync       = (require 'rsyncwrapper').rsync
path        = require 'path'
config      = require './config'


# Highly optimized require-dir instead of glob
# TODO: Try to use readdir as async option instead
for dir in ["./gulp/tasks"]

  files = fs.readdirSync(dir)
    .filter (name) -> /(\.(js|coffee|ls)$)/

  for name in files
    path = "./tasks/#{name}"
    conf = config[name] or config

    # Wrapper for tasks
    # This enables hooks for reading recipes and tasks
    task = ->
      gulp.task.apply gulp, arguments

    console.log path
    require(path)($, conf)
