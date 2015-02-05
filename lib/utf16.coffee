#
# Stream to convert UTF-8 to UTF16-LE
#
through = require 'through'

module.exports = ->
  through (data)->
    @queue new Buffer data.toString('utf8'), 'utf16le'
