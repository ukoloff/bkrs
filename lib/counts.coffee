#
# Report articles counts
#

fs = require 'fs'
yaml = require 'js-yaml'
appveyor = require 'appveyor-mocha'

counts = false

module.exports = fn = (k, v)->
  counts = start: new Date  unless counts
  counts[k] = v

  fn.report = (passThru)->
    console.log dump = yaml.dump counts
    fs.writeFile 'src/counts.yml', dump, ->
    if passThru
      appveyor.message 'Statistics', dump
