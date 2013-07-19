# Prepare
{TaskGroup} = require('taskgroup')
eachr = require('eachr')
feedr = new (require('feedr').Feedr)

# Export
module.exports = (BasePlugin) ->
	# Define
	class TumblrPlugin extends BasePlugin
		# Name
		name: 'tumblr'

		# Config
		config:
			blog: process.env.TUMBLR_BLOG
			apiKey: process.env.TUMBLR_API_KEY
			relativePath: "tumblr"
			extension: ".html"
			helper: null

		# Fetch our Tumblr Posts
		# next(err,tumblrPosts)
		fetchTumblrData: (opts={},next) ->
			# Prepare
			config = @getConfig()

			# Check
			if !config.blog or !config.apiKey
				err = new Error('Tumblr plugin is not configured correctly')
				return next(err)

			# Prepare
			{blog,apiKey} = config
			blog = blog+'.tumblr.com'  if blog.indexOf('.') is -1

			# Prepare
			tumblrUrl = "http://api.tumblr.com/v2/blog/#{blog}/posts?api_key=#{escape apiKey}"
			tumblrPosts = []

			# Read feeds
			feedr.readFeed tumblrUrl, (err,feedData) ->
				# Check
				return next(err)  if err

				# Concat the posts
				for tumblrPost in feedData.response.posts
					tumblrPosts.push(tumblrPost)

				# Fetch the remaining posts
				feeds = []
				for offset in [20...feedData.response.blog.posts] by 20
					feeds.push("#{tumblrUrl}&offset=#{offset}")
				feedr.readFeeds feeds, (err,feedsData) ->
					# Check
					return next(err)  if err

					# Cycle the data
					for feedData in feedsData
						for tumblrPost in feedData.response.posts
							tumblrPosts.push(tumblrPost)

					# Done
					return next(null, tumblrPosts)

			# Chain
			@


		# =============================
		# Events

		# Populate Collections
		# Import Tumblr Data into the Database
		populateCollections: (opts,next) ->
			# Prepare
			me = @
			config = @getConfig()
			docpad = @docpad
			database = docpad.getDatabase()
			docpadConfig = docpad.getConfig()

			# Log
			docpad.log('info', "Importing Tumblr posts...")

			# Fetch
			@fetchTumblrData null, (err,tumblrPosts) ->
				# Check
				return next(err)  if err

				# Inject our posts
				eachr tumblrPosts, (tumblrPost) ->
					# Prepare
					documentOpts = {}

					# Meta
					documentOpts.meta =
						tumblrId: tumblrPost.id
						tumblrType: tumblrPost.type
						tumblr: tumblrPost
						title: tumblrPost.title or null
						date: new Date(tumblrPost.date)
						tags: (tumblrPost.tags or []).concat([tumblrPost.type])
						relativePath: "#{config.relativePath}/#{tumblrPost.type}/#{tumblrPost.id}#{config.extension}"

					# Data
					documentOpts.data = tumblrPost.body or ''  # TODO: should we need the or ''
					delete tumblrPost.body

					# Create document from attributes
					document = docpad.createDocument(null, documentOpts)

					# Inject helper
					config.helper?.call(me, document)

					# Add it to the database
					database.add(document)

				# Log
				docpad.log('info', "Imported #{tumblrPosts.length} Tumblr posts...")

				# Complete
				return next()

			# Chain
			@

	###
	writeFiles: (opts,next) ->
		if @getConfig().writeSourcEfiles
			.writeSource()
	###