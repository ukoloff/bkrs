#
# Report articles counts
#

fs = require 'fs'
yaml = require 'js-yaml'

counts = false

module.exports = fn = (k, v)->
  counts = start: new Date  unless counts
  counts[k] = v

  fn.report = (appveyor)->
    console.log dump = yaml.dump counts
    fs.writeFile 'src/counts.yml', dump
    if appveyor
      require './appveyor'
      .message dump
