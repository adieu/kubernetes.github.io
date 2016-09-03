#!/usr/bin/env python

"""
Pandoc filter to remove jekyll toc tags.
"""

from pandocfilters import toJSONFilter, Str

def removetoc(key, value, format, meta):
  if key == 'BulletList':
    if len(value) == 1 and isinstance(value[0], list) and len(value[0]) == 1:
      toc = value[0][0]
      if isinstance(toc, dict) and toc['t'] == 'Plain' and len(toc['c']) == 3:
        if toc['c'][0]['t'] == 'Str' and toc['c'][0]['c'] == 'TOC':
          return []

if __name__ == "__main__":
  toJSONFilter(removetoc)
