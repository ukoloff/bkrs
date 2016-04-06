# bkrs

[![Build Status](https://travis-ci.org/ukoloff/bkrs.svg?branch=master)](https://travis-ci.org/ukoloff/bkrs)
[![Build status](https://ci.appveyor.com/api/projects/status/t20nx4hrs70ai4kt?svg=true)](https://ci.appveyor.com/project/ukoloff/bkrs)

Convert bkrs.info database to Dictan(zd/fdb/dsl) and GoldenDict(dsl) format

## Features

  * Index by pinyin (汉语拼音)
  * Index by traditional characters (繁體字)
  * Show traditional variant where appropriate
  * Examples injected into correspondent articles
  * Abbreviations added

Dictan version is combined: RU->ZH and ZH->RU versions in single file.

GoldenDict version contains two separate dictionaries: RU->ZH
(with pinyin, traditional index and examples) and ZH->RU.

## Installation

  * Install [Node.js](http://nodejs.org/download/)
  * git clone https://github.com/ukoloff/bkrs.git
  * cd bkrs
  * npm install --production

## Converting

  * Download current [BKRS sources](http://bkrs.info/p47) (*_yymmdd.gz files, see bottom of page)

    or just say `node lib/fetch` ;-)

  * Put them into src folder
  * npm start [--tags=format]
  * See sources for makezd in src folder

Feed src/articles.txt to makezd or Dictan converter.

Command `npm start --tags=dsl` will generate DSL formatted sources,
so feed it to new Dictan converter.
In addition src/*.dsl are good for GoldenDict.

## Nightly builds

This converter runs every night with fresh BKRS sources. Generated files are:

  * [bkrs.zd](https://ci.appveyor.com/api/projects/ukoloff/bkrs/artifacts/bkrs.zd) - for Dictan
  * [bkrs.zip](https://ci.appveyor.com/api/projects/ukoloff/bkrs/artifacts/bkrs.zip) - for GoldenDict
  * [bkrs-min.zip](https://ci.appveyor.com/api/projects/ukoloff/bkrs/artifacts/bkrs-min.zip) - for GoldenDict on Adroid (packed with dictzip)

## Development

  * npm install
  * npm test

## Credits

  * [BKRS](http://bkrs.info/)
  * [Dictan](http://www.softex.info/)
  * [GoldenDict](http://goldendict.org/)
  * [Node.js](http://nodejs.org/)
  * [DictZip@win32](https://github.com/Tvangeste/dictzip-win32/releases)
  * [Travis CI](https://travis-ci.org/)
  * [AppVeyor](http://www.appveyor.com/)
