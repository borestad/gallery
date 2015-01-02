# Readme:
# https://github.com/floridoo/gulp-sourcemaps/wiki/Plugins-with-gulp-sourcemaps-support
# https://github.com/mod-ui/mod-gulp/blob/master/main.ls
# https://github.com/m4n3z40/nextgen-stater-project/blob/master/gulpfile.js

# For development => gulp
# For production  => gulp -p
env         = (require 'minimist') process.argv.slice 2
$           = (require 'gulp-load-plugins') {lazy: true}
$.isProd    = !!env.p
$.isDev     = not $.isProd

buffer      = require 'vinyl-buffer'
coffeeify   = require 'coffeeify'
colors      = require 'colors'
fs          = require 'fs'
gulp        = require 'gulp'
liveify     = require 'liveify'
modRewrite  = require 'connect-modrewrite'
rsync       = (require 'rsyncwrapper').rsync
path        = require 'path'


tasks = (fs.readdirSync './gulp/tasks/').filter (name) -> /(\.(js|coffee|ls)$)/
for task in tasks
  t = require("./tasks/#{task}")
  if typeof t == 'function'
    t($)
