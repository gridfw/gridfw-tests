GridFw = require '../../../gridfw'

app = new GridFw()

app.get '/', (ctx) ->
	console.log '---- call home page'
	infos =
		app:
			uri: "#{app.protocol}://#{app.host}:#{app.port}#{app.path}"
			ip: app.ip
			ipType: app.ipType

	console.log '---- infos: ', infos
	ctx.send 'hello word'

app.listen(3000)
	.then ->
		console.log '--- App is running'
	.catch (err)->
		console.log '--- Got error: ', err