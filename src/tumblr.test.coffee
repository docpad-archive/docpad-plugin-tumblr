# Test our plugin using DocPad's Testers
require('docpad').require('testers').test({
	pluginPath: __dirname+'/..'
	testerClass: 'RendererTester'
	removeWhitespace: true
	contentRemoveRegex: ///
		# erase play field
		"plays":\s*[0-9]+,

		|
		# erase media field
		".+?media\.tumblr\.com.+?"

		|
		# erase entire thumbnail line
		"thumbnail.+?,

		///gm
})