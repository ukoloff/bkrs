fs = require 'fs'

module.exports = fs.readdirSync 'src'
.reduce (max, name)->
  if (m = /_(\d+)[.]gz/.exec name) && (m = m[1]).length>=max.length && m>max
    m
  else
    max
, ''
