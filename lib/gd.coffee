#
# Generate GoldenDict dictionaries
#
fs = require 'fs'
path = require 'path'
yaml = require 'js-yaml'
through2 = require 'through2'
multistream = require 'multistream'

log = require './log'
utf16 = require './utf16'

log 'Creating GoldenDict dictionaries...'

ini = yaml.safeLoad  fs.readFileSync path.join __dirname, '../extras/gd.yml'

# Create output files and write headers
out = for k, v of ini.out
  x = through2()
  x
  .pipe utf16()
  .pipe fs.createWriteStream "src/#{k}.dsl"
  for p, q of v
    x.write "##{p.toUpperCase()} \"#{q}\"\n"
  for p, q of ini.common
    x.write "##{p} #{q}\n"
  x

files = []  # Streams to join to bkrs.dsl

for file in require './reorder'
  src = fs.createReadStream "src/#{file}"
  if file==ini.other
    src.pipe out[1]
  else
    files.push src

# Generate abbreviations
fs.createReadStream "src/abbreviations.dsl"
.pipe out[2]
.on 'finish', ->
  # Copy abbreviations to real names
  for k of ini.out when /^b/.test k
    fs.createReadStream 'src/abrv.dsl'
    .pipe fs.createWriteStream "src/#{k}_abrv.dsl"

# Merge bkrs.dsl
multistream files
.pipe out[0]
# .on 'finish', ->
