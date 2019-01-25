gulp			= require 'gulp'
gutil			= require 'gulp-util'
# minify		= require 'gulp-minify'
include			= require "gulp-include"
uglify			= require 'gulp-uglify-es'
rename			= require "gulp-rename"
coffeescript	= require 'gulp-coffeescript'
PluginError		= gulp.PluginError
cliTable		= require 'cli-table'
Gi18nCompiler = require 'gridfw-i18n-gulp'
Template		= require 'gulp-template'

# settings
settings=
	mode: gutil.env.mode || 'dev'
	isProd: gutil.env.mode is 'prod'

# compile final values (consts to be remplaced at compile time)
# handlers
compileCoffee = ->
	glp = gulp.src ['assets/**/[!_]*.coffee', '!assets/i18n/**/*.coffee'], nodir: true
		# include related files
		.pipe include hardFail: true
		# templating
		.pipe Template settings
		# convert to js
		.pipe coffeescript(bare: true).on 'error', errorHandler
	# if is prod
	if settings.isProd
		glp = glp.pipe uglify()
	# dest
	glp.pipe gulp.dest 'build'
		.on 'error', errorHandler
# i18n
compileI18n = ->
	gulp.src 'assets/i18n/**/*.coffee'
		.pipe coffeescript bare: true
		.pipe Gi18nCompiler()
		.pipe gulp.dest 'build/i18n'
		.on 'error', gutil.log
# watch files
watch = ->
	gulp.watch ['assets/**/[!_]*.coffee', '!assets/i18n/**/*.coffee'], compileCoffee
	gulp.watch 'assets/i18n/**/*.coffee', compileI18n
	return

# error handler
errorHandler= (err)->
	# get error line
	expr = /:(\d+):(\d+):/.exec err.stack
	if expr
		line = parseInt expr[1]
		col = parseInt expr[2]
		code = err.code?.split("\n")[line-3 ... line + 3].join("\n")
	else
		code = line = col = '??'
	# Render
	table = new cliTable()
	table.push {Name: err.name},
		{Filename: err.filename},
		{Message: err.message},
		{Line: line},
		{Col: col}
	console.error table.toString()
	console.log '\x1b[31mStack:'
	console.error '\x1b[0m┌─────────────────────────────────────────────────────────────────────────────────────────┐'
	console.error '\x1b[34m', err.stack
	console.log '\x1b[0m└─────────────────────────────────────────────────────────────────────────────────────────┘'
	console.log '\x1b[31mCode:'
	console.error '\x1b[0m┌─────────────────────────────────────────────────────────────────────────────────────────┐'
	console.error '\x1b[34m', code
	console.log '\x1b[0m└─────────────────────────────────────────────────────────────────────────────────────────┘'
	return

# default task
gulp.task 'default', gulp.series gulp.parallel(compileCoffee, compileI18n), watch