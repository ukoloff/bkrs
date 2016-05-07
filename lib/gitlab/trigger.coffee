url = require 'url'
https = require 'https'
querystring = require 'querystring'

return unless process.env.APPVEYOR_SCHEDULED_BUILD and
  process.env.GITLAB_TOKEN and
  process.env.GITLAB_TRIGGER

API = 'https://gitlab.com/api/v3/projects/1151002/trigger/builds'
TOKEN = '97bf6ccb338f3362ca7e2b408f4eca'

console.log "Triggering GitLab build"

z = url.parse process.env.GITLAB_TRIGGER
z.method = 'POST'

https.request z
.on 'error', (e)->
  console.log "HTTP Error: #{e}"
  process.exit 1
.on 'response', ->
  console.log "Ok"
.end querystring.stringify
  token: process.env.GITLAB_TOKEN
  ref: 'master'
