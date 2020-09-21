#!/usr/bin/env coffee
import merkle from '@rmw/merkle'
# import {merkle as Xxx} from '@rmw/merkle'
import test from 'tape-catch'

test 'merkle', (t)=>
  t.equal merkle(1,2),3
  # t.deepEqual Xxx([1],[2]),[3]
  t.end()
