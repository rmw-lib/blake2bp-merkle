<!-- 本文件由 ./readme.make.md 自动生成，请不要直接修改此文件 -->

# @rmw/merkle

##  安装

```
yarn add @rmw/merkle
```

或者

```
npm install @rmw/merkle
```

## 使用

```
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

```

## 关于

本项目隶属于**人民网络([rmw.link](//rmw.link))** 代码计划。

![人民网络](https://raw.githubusercontent.com/rmw-link/logo/master/rmw.red.bg.svg)
