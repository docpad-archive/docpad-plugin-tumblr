# Test our plugin using DocPad's Testers
require('docpad').require('testers').test({
	pluginPath: __dirname+'/..'
	testerClass: 'RendererTester'
	contentRemoveRegex: ///
		\\"plays\\":\s+[0-9]+,
		|
		[0-9]+\.media\.tumblr\.com
		|
		\s+.+?thumbnail.+?,
		///gm
})