# My experimental photo gallery

# Techniques used
- [GulpJS](http://gulpjs.com/)
- [Jade](http://jade-lang.com/)
- [Stylus](http://learnboost.github.io/stylus/)
- [Browserify](http://browserify.org/)
- [Karma](http://karma-runner.github.io/)
- [Jeet](http://jeet.gs/)
- [Kouto Swiss](http://kouto-swiss.io/)
- [Rupture](https://github.com/jenius/rupture)

### Tasks

- `gulp`: Initialize watch for changes and a server(localhost:8080)
- `gulp fy`: Initialize watch for changes and a server(localhost:8080) using browserify mode
- `gulp js`: execute js files
- `gulp browserify`: execute js files in browserify mode
- `gulp jade`: compile jade files
- `gulp stylus`: compile stylus files
- `gulp imagemin`:compress image files
- `gulp connect`: inicialize a server
- `gulp watch`: call for watch files
- `gulp -p`: minify all files for production
- `gulp fy -p`: minify all files for production (browserify mode)
- `gulp build -p`: minify files and deploy via rsync
- `gulp buildfy -p`: minify files and deploy via rsync (browserify mode)
- `karma start`: launch a phantonjs and watch for tests


# Borrows a lot of inspiration and ideas from open source packages
- https://github.com/willianjusten/Fast
- https://github.com/KyleAMathews/coffee-react-quickstart
- https://github.com/pilwon/ultimate-seed
