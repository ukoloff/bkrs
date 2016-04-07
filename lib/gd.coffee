#
# Generate GoldenDict dictionaries
#
fs = require 'fs'
path = require 'path'
yaml = require 'js-yaml'
multistream = require 'multistream'

log = require './log'
utf16 = require './utf16'

log 'Creating GoldenDict dictionaries...'

outs = {}     # Output streams
joiner = 0    # Joined stream
singles = {}  # Single inputs

# Create output files and write headers
ini = yaml.safeLoad  fs.readFileSync path.join __dirname, '../extras/gd.yml'
for k, v of ini.out
  outs[k] = x = utf16()
  x.pipe fs.createWriteStream "src/#{k}.dsl"

  # Write header
  for p, q of v when not /^_/.test p
    x.write "##{p.toUpperCase()} \"#{q}\"\n"
  for p, q of ini.common
    x.write "##{p} #{q}\n"

  if v._from
    singles[v._from] = 1
    fs.createReadStream "src/#{v._from}"
    .pipe x
  else
    joiner = x

# Generate abbreviations
outs['abrv'].on 'finish', ->
  # Copy abbreviations to real names
  for k of ini.out when /^b/.test k
    fs.createReadStream 'src/abrv.dsl'
    .pipe fs.createWriteStream "src/#{k}_abrv.dsl"

# Merge bkrs.dsl
joined = for file in require './reorder' when not singles[file]
  fs.createReadStream "src/#{file}"
multistream joined
.pipe joiner
# .on 'finish', ->
