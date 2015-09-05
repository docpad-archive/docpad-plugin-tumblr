# [Tumblr](https://www.tumblr.com/) Importer Plugin for [DocPad](http://docpad.org)

<!-- BADGES/ -->

[![Build Status](http://img.shields.io/travis-ci/docpad/docpad-plugin-tumblr.png?branch=master)](http://travis-ci.org/docpad/docpad-plugin-tumblr "Check this project's build status on TravisCI")
[![NPM version](http://badge.fury.io/js/docpad-plugin-tumblr.png)](https://npmjs.org/package/docpad-plugin-tumblr "View this project on NPM")
[![Dependency Status](https://david-dm.org/docpad/docpad-plugin-tumblr.png?theme=shields.io)](https://david-dm.org/docpad/docpad-plugin-tumblr)
[![Development Dependency Status](https://david-dm.org/docpad/docpad-plugin-tumblr/dev-status.png?theme=shields.io)](https://david-dm.org/docpad/docpad-plugin-tumblr#info=devDependencies)<br/>
[![Gittip donate button](http://img.shields.io/gittip/docpad.png)](https://www.gittip.com/docpad/ "Donate weekly to this project using Gittip")
[![Flattr donate button](http://img.shields.io/flattr/donate.png?color=yellow)](http://flattr.com/thing/344188/balupton-on-Flattr "Donate monthly to this project using Flattr")
[![PayPal donate button](http://img.shields.io/paypal/donate.png?color=yellow)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=QB8GQPZAH84N6 "Donate once-off to this project using Paypal")
[![BitCoin donate button](http://img.shields.io/bitcoin/donate.png?color=yellow)](https://coinbase.com/checkouts/9ef59f5479eec1d97d63382c9ebcb93a "Donate once-off to this project using BitCoin")
[![Wishlist browse button](http://img.shields.io/wishlist/browse.png?color=yellow)](http://amzn.com/w/2F8TXKSNAFG4V "Buy an item on our wishlist for us")

<!-- /BADGES -->


Import your Tumblr content directly into your DocPad database


## Install

```
docpad install tumblr
```


## Configuration

### Specifying your Blog

You need to specify `TUMBLR_BLOG` (e.g. `balupton.tumblr.com`) and your `TUMBLR_KEY` in either your [`.env` configuration file](http://docpad.org/docs/config#environment-configuration-file) like so:

```
TUMBLR_BLOG=balupton.tumblr.com
TUMBLR_API_KEY=123
```

Or via your [docpad configuration file](http://docpad.org/docs/config) via:

``` coffee
plugins:
	tumblr:
		blog: 'balupton.tumblr.com'
		apiKey: '123'
```

You can [create a new Tumblr API KEY here](http://www.tumblr.com/oauth/register) or [find your exiting ones here](http://www.tumblr.com/oauth/apps). Your API KEY is the same as your OAuth Consumer Key.


### Customising the Output

The default directory for where the imported documents will go inside is the `tumblr` directory. You can customise this using the `relativeDirPath` plugin configuration option.

The default extension for imported documents is `.json`. You can customise this with the `extension` plugin configuration option.

The default content for the imported documents is the serialised tumblr data as JSON data. You can can customise this with the `injectDocumentHelper` plugin configuration option which is a function that takes in a single [Document Model](https://github.com/bevry/docpad/blob/master/src/lib/models/document.coffee).

If you would like to render a partial for the tumblr data type, add a layout, and change the extension, you can this with the following plugin configuration:

``` coffee
extension: '.html.eco'
injectDocumentHelper: (document) ->
	document.setMeta(
		layout: 'default'
		tags: (document.get('tags') or []).concat(['post'])
		data: """
			<%- @partial('post/'+@document.tumblr.type, @extend({}, @document, @document.tumblr)) %>
			"""
	)
```

You can find a great example of this customisation within the [syte skeleton](https://github.com/docpad/syte.docpad) which combines the tumblr plugin with the [partials plugin](http://docpad.org/plugin/partials) as well as the [tags plugin](http://docpad.org/plugin/tags) and [paged plugin](http://docpad.org/plugin/paged).


### Creating a File Listing

As imported documents are just like normal documents, you can also list them just as you would other documents. Here is an example of a `index.html.eco` file that would output the titles and links to all the imported tumblr documents:

``` erb
<h2>Tumblr:</h2>
<ul><% for file in @getFilesAtPath('tumblr/').toJSON(): %>
	<li>
		<a href="<%= file.url %>"><%= file.title %></a>
	</li>
<% end %></ul>
```

<!-- HISTORY/ -->

## History
[Discover the change history by heading on over to the `HISTORY.md` file.](https://github.com/docpad/docpad-plugin-tumblr/blob/master/HISTORY.md#files)

<!-- /HISTORY -->


<!-- CONTRIBUTE/ -->

## Contribute

[Discover how you can contribute by heading on over to the `CONTRIBUTING.md` file.](https://github.com/docpad/docpad-plugin-tumblr/blob/master/CONTRIBUTING.md#files)

<!-- /CONTRIBUTE -->


<!-- BACKERS/ -->

## Backers

### Maintainers

These amazing people are maintaining this project:

- Benjamin Lupton <b@lupton.cc> (https://github.com/balupton)

### Sponsors

No sponsors yet! Will you be the first?

[![Gittip donate button](http://img.shields.io/gittip/docpad.png)](https://www.gittip.com/docpad/ "Donate weekly to this project using Gittip")
[![Flattr donate button](http://img.shields.io/flattr/donate.png?color=yellow)](http://flattr.com/thing/344188/balupton-on-Flattr "Donate monthly to this project using Flattr")
[![PayPal donate button](http://img.shields.io/paypal/donate.png?color=yellow)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=QB8GQPZAH84N6 "Donate once-off to this project using Paypal")
[![BitCoin donate button](http://img.shields.io/bitcoin/donate.png?color=yellow)](https://coinbase.com/checkouts/9ef59f5479eec1d97d63382c9ebcb93a "Donate once-off to this project using BitCoin")
[![Wishlist browse button](http://img.shields.io/wishlist/browse.png?color=yellow)](http://amzn.com/w/2F8TXKSNAFG4V "Buy an item on our wishlist for us")

### Contributors

These amazing people have contributed code to this project:

- [Benjamin Lupton](https://github.com/balupton) <b@lupton.cc> — [view contributions](https://github.com/docpad/docpad-plugin-tumblr/commits?author=balupton)

[Become a contributor!](https://github.com/docpad/docpad-plugin-tumblr/blob/master/CONTRIBUTING.md#files)

<!-- /BACKERS -->


<!-- LICENSE/ -->

## License

Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT license](http://creativecommons.org/licenses/MIT/)

Copyright &copy; Bevry Pty Ltd <us@bevry.me> (http://bevry.me)

<!-- /LICENSE -->


