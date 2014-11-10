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
      create  tmp/preview/index.html
 {build => tmp/preview}/index.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/build/index.html b/tmp/preview/index.html
index 68c37b9..218e4ff 100644
--- a/build/index.html
+++ b/tmp/preview/index.html
@@ -5,6 +5,6 @@
   </head>
   <body>
     <h1>Hello there!</h1>
-    <p>This site is kind of alright.</p>
+    <p>This site is awesome.</p>
   </body>
 </html>
Would you like to apply these changes to the build? [y/N] y
Build has been updated.
```

## Configuration

The following configuration options are available:

Name          | Default   | Description
------------- | --------- | ---------------------------------------------------
`build_hooks` | `true`    | Whether to run build hooks when previewing the build
`keep`        | `:prompt` | Whether to `:always`, `:never`, or `:prompt` to keep the preview as the build
`temp_dir`    | `'tmp'`   | Directory in which to build when previewing


  [build-status]: https://travis-ci.org/AndrewKvalheim/middleman-diff
  [build-status-badge]: https://travis-ci.org/AndrewKvalheim/middleman-diff.png?branch=master
  [gem-version]: https://badge.fury.io/rb/middleman-diff
  [gem-version-badge]: https://badge.fury.io/rb/middleman-diff.png
  [middleman]: http://middlemanapp.com/
