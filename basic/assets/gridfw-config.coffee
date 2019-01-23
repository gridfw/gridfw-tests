###*
 * Config file
###
module.exports=
	### DEV PLUGINS ###
	devPlugins:
		devTools:
			require: '../../../dev-tools'
	### PLUGINS ###
	plugins:
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