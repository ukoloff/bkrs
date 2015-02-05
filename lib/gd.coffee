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
config = require '../package'

log 'Creating GoldenDict dictionaries...'

ini = yaml.safeLoad  fs.readFileSync path.join __dirname, 'gd.yml'

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

seq config.sources.concat config.extras
.step (file, done)->
  fs.createReadStream "src/#{file}"
  .on 'end', done
  .pipe out[Number file==ini.other]
