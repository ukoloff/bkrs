#
# Generate GoldenDict dictionaries
#
fs = require 'fs'
path = require 'path'
yaml = require 'js-yaml'
through = require 'through'

log = require './log'
seq = require './seq'
utf16 = require './utf16'

log 'Creating GoldenDict dictionaries...'

ini = yaml.safeLoad  fs.readFileSync path.join __dirname, '..', 'extras', 'gd.yml'

out = for k, v of ini.out
  x = through(null, ->)
  x
  .pipe utf16()
  .pipe fs.createWriteStream "src/#{k}.dsl"
  for p, q of v
    x.write "##{p.toUpperCase()} \"#{q}\"\n"
  for p, q of ini.common
    x.write "##{p} #{q}\n"
  x

seq require './reorder'
.step (i, file, done)->
  fs.createReadStream "src/#{file}"
  .on 'end', done
  .pipe out[Number file==ini.other]
.done ->
  fs.createReadStream "src/abbreviations.dsl"
  .on 'end', rename
  .pipe out[2]

rename = ->
  for k of ini.out when /^b/.test k
    fs.createReadStream 'src/abrv.dsl'
    .pipe fs.createWriteStream "src/#{k}_abrv.dsl"
