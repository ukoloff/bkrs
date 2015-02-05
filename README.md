# bkrs

[![Build Status](https://travis-ci.org/ukoloff/bkrs.svg?branch=master)](https://travis-ci.org/ukoloff/bkrs)

Convert bkrs.info database to Dictan(zd/fdb) and GoldenDict(dsl) format

## Installation

  * Install [Node.js](http://nodejs.org/download/)
  * git clone https://github.com/ukoloff/bkrs.git
  * cd bkrs
  * npm install --production

## Usage

  * Download current [BKRS sources](http://bkrs.info/p47) (*_yymmdd.gz files, see bottom of page)
  * Put them into src folder
  * npm start [--tags=format]
  * See sources for makezd in src folder

Feed src/bkrs.txt to makezd or Dictan converter.

Command `npm start --tags=dsl` will make it DSL formatted, so feed it to new Dictan converter.
In addition src/*.dsl are good for GoldenDict.

## Development

  * npm install
  * npm test

## Credits
  * [BKRS](http://bkrs.info/)
  * [Dictan](http://www.softex.info/)
  * [GoldenDict](http://goldendict.org/)
  * [Node.js](http://nodejs.org/)
  * [Travis CI](https://travis-ci.org/)
