module.exports =
	plugins:
		tumblr:
			injectDocumentHelper: (document) ->
				document.setMeta(
					layout: 'tumblr'
				)
				###
				.set(
					writeSource: true
					fullPath: @docpad.getConfig().srcPath+'/documents/'+document.get('relativePath')
				)
				###