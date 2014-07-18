![banner](resources/banner.png)

## Installation

`$ gem install xcodebump`

## Usage

```bash
$ cd /path/where/my/project/lives
$ xcodebump bump (-r, -m, -p)
```

To bump a version number, you want to pass in one of the three flags in the parentheses above. The one to pass in depends entirely upon which part of the version you want to bump.

**1.2.3**

* `-r` will bump the Release number, or the 1 above.
* `-m` will bump the Minor number, or the 2 above.
* `-p` will bump the Patch number, or the 3 above.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/xcodebump/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
