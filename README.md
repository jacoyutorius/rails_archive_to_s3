# ArchiveToS3
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'archive_to_s3'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install archive_to_s3
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## refs

- https://railsguides.jp/plugins.html
- http://morizyun.github.io/blog/ruby-gem-easy-publish-library-rails/
- [Ruby on Rails | Railsプラグインの開発時にrakeタスクを作成する方法](http://tbpgr.hatenablog.com/entry/20130904/1378306296)

## commands

```console
rails plugin new archive_to_s3
```



---

## memo

### "can't dup NilClass"

```console
$ bin/test
/Users/yuto-ogi/Work/rails/archive_to_s3/.bundle/ruby/2.4.0/gems/sprockets-3.7.1/lib/sprockets/utils.rb:40:in `dup': can't dup NilClass (TypeError)
	from /Users/yuto-ogi/Work/rails/archive_to_s3/.bundle/ruby/2.4.0/gems/sprockets-3.7.1/lib/sprockets/utils.rb:40:in `hash_reassoc1'
	from /Users/yuto-ogi/Work/rails/archive_to_s3/.bundle/ruby/2.4.0/gems/sprockets-3.7.1/lib/sprockets/utils.rb:65:in `hash_reassoc'
	from /Users/yuto-ogi/Work/rails/archive_to_s3/.bundle/ruby/2.4.0/gems/sprockets-3.7.1/lib/sprockets/transformers.rb:142:in `compute_transformers!'
	from /Users/yuto-ogi/Work/rails/archive_to_s3/.bundle/ruby/2.4.0/gems/sprockets-3.7.1/lib/sprockets/processing.rb:216:in `register_config_processor'
```

thank to http://sonken625.hatenablog.com/entry/2017/02/26/035340.

