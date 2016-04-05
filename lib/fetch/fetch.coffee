fs = require 'fs'
url = require 'url'
path = require 'path'
request = require 'request'
trumpet = require 'trumpet'

base = 'http://bkrs.info/p47'

console.log "Fetching #{base}..."

request base
.pipe tr = do trumpet

tr.selectAll 'a[href$=gz]', (a)->
  a.getAttribute 'href', (href)->
    return unless /// /(\w+)_\d+[.]gz$ ///.test href
    console.log "Fetching #{x = url.resolve base, href}..."
    request x
    .pipe fs.createWriteStream path.join 'src', file = path.basename url.parse(x).pathname
    .on 'finish', ->
      console.log "Got #{file}."
