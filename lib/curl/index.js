//
// Minimal curl implementation
//
const url = require('url')
const fs = require('fs')

if(4 != process.argv.length)
{
  console.error('Usage:', process.argv[1], 'URL', 'file')
  process.exit(1)
}

get(process.argv[2])

function get(uri)
{
  let src = url.parse(uri)

  require(/https/.test(src.protocol) ? 'https' : 'http')
    .get(src, store)
}

function store(resp)
{
  if(/^3/.test(resp.statusCode))
    get(resp.headers.location)
  else
    resp.pipe(fs.createWriteStream(process.argv[3]))
}
