#
#  AppVeyor Build Worker API <http://www.appveyor.com/docs/build-worker-api>
#
http = require 'http'
url = require 'url'

api = process.env.APPVEYOR_API_URL

@message = (msg)->
  return unless api

  body = JSON.stringify
    message: msg
    category: 'info'

  z = url.parse api
  z.method = 'POST'
  z.path = '/api/build/messages'
  z.headers =
    'Content-Type': 'application/json'
    'Content-Length': body.length

  http.request z
  .on 'error', (e)->
    console.error "HTTP error: #{e.message}"
  .end body
