#!/usr/bin/env coffee

import blake from 'blake3'
import {Writable,Transform} from 'stream'

hasher = =>
  blake.createHash()

export MB = 1048576

export class Blake2 extends Transform
  constructor:->
    super()
    @size = 0
    @hash = hasher()
    @total = 0

  _transform:(buf,enc,next)->
    {size, hash} = @
    diff = MB - size
    buf_len = buf.length

    if diff > buf_len
      hash.update buf
      @size += buf_len
    else
      @push hash.update(
        if diff == buf_len then buf else buf.slice(0, diff)
      ).digest()
      @total += MB
      @size = 0
      @hash = hasher()
      if buf_len > diff
        return @_transform(buf.slice(diff), enc, next)
    next()

  _flush:(next)->
    @total+=@size
    @push @hash.digest()
    next()

export class BufferStreamLi extends Writable
  constructor:->
    super()
    @_ = []

  _write : (buf, enc, next)->
    @_.push buf
    next()

  # _final: (next)->
  #   next()

export merkle = (li)=>
  li = li.slice()
  len = li.length
  while len > 1
    t = []
    if len % 2
      t.push li.pop()
      --len
    # console.log "len", len
    n = len
    while n
      n-=2
      # console.log n+1, n
      t.push hasher().update(Buffer.concat [li[n+1],li[n]]).digest()
    # console.log t
    # console.log "---"
    len = len/2
    li = t
  return li[0]


