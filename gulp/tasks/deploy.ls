require! 'gulp'

module.exports = ($, options) ->

  gulp.task 'deploy', ->
    do
      <- $.rsync do
        ssh: true,
        src: './build/',
        dest: 'user@hostname:/path/to/www',
        recursive: true,
        syncDest: true,
        args: ['--verbose']
      (erro, stdout, stderr, cmd) ->
        $.util.log(stdout)
