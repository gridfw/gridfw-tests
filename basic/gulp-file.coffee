gulp			= require 'gulp'
gutil			= require 'gulp-util'
# minify		= require 'gulp-minify'
include			= require "gulp-include"
uglify			= require 'gulp-uglify-es'
# rename			= require "gulp-rename"
coffeescript	= require 'gulp-coffeescript'
Gi18nCompiler = require 'gridfw-i18n-gulp'

GfwCompiler		= require 'gridfw-compiler'

# settings
isProd= gutil.env.hasOwnProperty('prod')
settings=
	mode: if isProd then 'prod' else 'dev'
	isProd: isProd

# compile final values (consts to be remplaced at compile time)
# handlers
compileCoffee = ->
	glp = gulp.src ['assets/**/[!_]*.coffee', '!assets/i18n/**/*'], nodir: true
		# include related files
		.pipe include hardFail: true
		# templating
		.pipe GfwCompiler.template settings
		# convert to js
		.pipe coffeescript(bare: true).on 'error', GfwCompiler.logError
	# if is prod
	if settings.isProd
		glp = glp.pipe uglify()
	# dest
	glp.pipe gulp.dest 'build'
		.on 'error', GfwCompiler.logError
# i18n
compileI18n = ->
	gulp.src 'assets/i18n/**/*.coffee'
		.pipe coffeescript bare: true
		.pipe Gi18nCompiler()
		.pipe gulp.dest 'build/i18n'
		.on 'error', GfwCompiler.logError

# compile views
compileViews = ->
	gulp.src 'assets/views/**/[!_]*.pug'
	# gulp.src ['assets/views/**/[!_]*.pug', 'assets/views/**/[!_]*.ejs']
		.pipe GfwCompiler.views()
		.pipe gulp.dest 'build/views'
		.on 'error', GfwCompiler.logError
# watch files
watch = (cb)->
	unless settings.isProd
		gulp.watch ['assets/**/[!_]*.coffee', '!assets/i18n/**/*.coffee'], compileCoffee
		gulp.watch 'assets/i18n/**/*.coffee', compileI18n
		gulp.watch 'assets/views/**/*.pug', compileViews
	cb()
	return

# default task
gulp.task 'default', gulp.series gulp.parallel(compileCoffee, compileViews, compileI18n), watch