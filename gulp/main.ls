# https://github.com/mod-ui/mod-gulp

class Main
    (@gulp, {source = {}, destination = {}} = {}) ->
        @source-override = source
        @destination-override = destination
        @source =
            path: source.path || './src/'
            name: source.name || 'main'
            extension: source.extension || '.*'
            get-main: -> @name + @extension
            get-main-path: -> @path + @get-main!
            get-pattern: -> @path + '**/*' + @extension

        @destination =
            path: destination.path || './dist/dev/'
            name: destination.name || 'main'
            extension: destination.extension || ''
            get-main: -> @name + @extension
            get-main-path: -> @path + @get-main!
            get-pattern: -> @path + '**/*' + @extension

    set-source-default: (properties) ->
        for key, property of properties
            if @source-override[key] is undefined
                @source[key] = property

    set-destination-default: (properties) ->
        for key, property of properties
            if @destination-override[key] is undefined
                @destination[key] = property

    init: ->
        console.log 'init not implemented - extend mod-gulp and add "init" method'

    log-error: (error) ->
        require! 'gulp-util'
        gulp-util.log gulp-util.colors.red(error.plugin), error.message
        @emit 'end'

    clean-destination: (callback) ->
        require! 'del'
        del @destination.get-pattern!, callback

    clean-main: (callback) ->
        require! 'del'
        del @destination.get-main-path!, callback


export Main
