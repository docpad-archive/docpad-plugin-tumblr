# [Tumblr](https://www.tumblr.com/) Importer Plugin for [DocPad](http://docpad.org)

[![Build Status](https://secure.travis-ci.org/docpad/docpad-plugin-tumblr.png?branch=master)](http://travis-ci.org/docpad/docpad-plugin-tumblr "Check this project's build status on TravisCI")
[![NPM version](https://badge.fury.io/js/docpad-plugin-tumblr.png)](https://npmjs.org/package/docpad-plugin-tumblr "View this project on NPM")
[![Gittip donate button](http://badgr.co/gittip/docpad.png)](https://www.gittip.com/docpad/ "Donate weekly to this project using Gittip")
[![Flattr donate button](https://raw.github.com/balupton/flattr-buttons/master/badge-89x18.gif)](http://flattr.com/thing/344188/balupton-on-Flattr "Donate monthly to this project using Flattr")
[![PayPayl donate button](https://www.paypalobjects.com/en_AU/i/btn/btn_donate_SM.gif)](https://www.paypal.com/au/cgi-bin/webscr?cmd=_flow&SESSION=IHj3DG3oy_N9A9ZDIUnPksOi59v0i-EWDTunfmDrmU38Tuohg_xQTx0xcjq&dispatch=5885d80a13c0db1f8e263663d3faee8d14f86393d55a810282b64afed84968ec "Donate once-off to this project using Paypal")

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


## History
[You can discover the history inside the `History.md` file](https://github.com/bevry/docpad-plugin-tumblr/blob/master/History.md#files)


## Contributing
[You can discover the contributing instructions inside the `Contributing.md` file](https://github.com/bevry/docpad-plugin-tumblr/blob/master/Contributing.md#files)


## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2013+ [Bevry Pty Ltd](http://bevry.me) <us@bevry.me>