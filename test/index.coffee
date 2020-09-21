#!/usr/bin/env coffee
import {Hash,BufferStreamLi,merkle} from '@rmw/merkle'
import test from 'tape-catch'
import fs from 'fs'
import blake from 'blake3'

class Hasher
  constructor:->
    @_ = blake.createHash()

  update:(buf)->
    @_.update buf

  digest:->
    h = @_.digest()
    h

hasher = =>
  new Hasher()

test 'merkle', (t)=>
  blake_stream = new Hash(hasher)
  bsli = new BufferStreamLi()

  bsli.on 'finish', (r)->
    console.log blake_stream.total
    console.log @_
    console.log merkle(@_)
    console.log @_.length

  fs.createReadStream(
    `import.meta.url.slice(7)`
  ).pipe(blake_stream).pipe(bsli)

  t.end()
