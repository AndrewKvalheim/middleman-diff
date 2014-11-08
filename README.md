# middleman-diff

[![Gem Version][gem-version-badge]][gem-version]
[![Build Status][build-status-badge]][build-status]

Preview what's changed in your [Middleman][middleman] build.

## Installation

Add the extension to your `Gemfile`,

```ruby
gem 'middleman-diff'
```

run `bundle install`, and activate it in `config.rb`:

```ruby
activate :diff
```

## Usage

Preview what's changed since the last build, and optionally use it as the
current build:

```console
$ middleman diff
--- a/index.html
+++ b/index.html

   <h1>Hello there!</h1>
-  <p>This site is kind of alright.</p>
+  <p>This site is awesome.</p>

Would you like to keep this build? [y/N] y
Build has been updated.
```

## Configuration

The following configuration options are available:

Name          | Default   | Description
------------- | --------- | ---------------------------------------------------
`build_hooks` | `false`   | Whether to run `after_build` hooks after keeping the build
`keep`        | `:prompt` | Whether to keep the build always (`:always`), never (`:never`), or to prompt each time (`:prompt`)
`temp_dir`    | `'tmp'`   | Path in which to build when previewing


  [build-status]: https://travis-ci.org/AndrewKvalheim/middleman-diff
  [build-status-badge]: https://travis-ci.org/AndrewKvalheim/middleman-diff.png?branch=master
  [gem-version]: https://badge.fury.io/rb/middleman-diff
  [gem-version-badge]: https://badge.fury.io/rb/middleman-diff.png
  [middleman]: http://middlemanapp.com/
