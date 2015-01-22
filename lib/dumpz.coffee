through = require 'through'

module.exports = ->

  through (art)->
    word = art.shift().replace /\s+/, ' '
    @queue "#{word}  #{art.map((s)-> "<div>#{s}</div>").join ' '}\n"
