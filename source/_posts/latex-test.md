---
title: latex test
abbrlink: 4d56e4ff
date: 2024-08-16 08:09:21
tags: latex 
---
## Installing Steps

1. `npm un hexo-renderer-marked --save`
2. `npm install markdown-it`
3. `npm install @iktakahiro/markdown-it-katex`
4. `npm i hexo-renderer-markdown-it-katex`

## config.yaml
```yaml
markdown:
  render:
    html: true
    xhtmlOut: false
    breaks: true
    linkify: true
    typographer: true
  plugins: 
    - plugin:
        name: markdown-it-katex
        enable: true
  anchors:
    level: 1
    collisionSuffix: ''
```
## Result
### with `$x_s+y^3=123$`
$x_s + y^3 = 123$

### with `$$x_s + y^3 = 123$$`
$$x_s + y^3 = 123$$