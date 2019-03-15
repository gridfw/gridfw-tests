###*
 * Config file
###
module.exports=
	### APP INFO ###
	name: 'Basic Gridfw app'
	email: 'contact@gridfw.com'
	author: 'Gridfw team'
	### APP STATUS ###
	# mode
	isProd: '<%= isProd %>'
	### PLUGINS ###
	plugins:
		# # dev plugins
		<% if(!isProd){ %>
		devTools:
			require: '../../../dev-tools'
		errorHandling:
			require: '../../../gridfw-errors'
		<% } %>
		
		# common plugins
		i18n:
			require: '../../../i18n'
			locals: 'i18n/**/*.js'	# local files
			default: 'en'			# default local
			param: 'i18n'			# param name as: ctx.i18n & ctx.locals.i18n
			setLangParam: 'set-lang'# query param to use to change language: ie: ?set-lang=en
			cache: on				# optimize memory by using cache, load only used languages

			# store lang inside user session: use
			session: 'i18n'			# param name inside session
			# or:
			# session:
			# 	get: (ctx)-> ctx.user.local
			# 	set: (ctx, value)-> ctx.user.local = value

			# - to use a context related language; ie: language is determined by the url:
			# - Options1: by query param: xxxx?lang=en
			# ctxLocal: (ctx)-> ctx.query.lang
			# - Options 2: inside URL: like: /fr/path/to/...
			# ctxLocal: (ctx)->
			# 	matches = ctx.path.match /^\/([a-z]*)(.*)/
			# 	ctx.path = matches[2]
			# 	return matches[1]