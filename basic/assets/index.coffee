GridFw = require '../../../gridfw'

app = new GridFw()

app.get '/', (ctx) ->
	infos =
		app:
			uri: "#{app.protocol}://#{app.host}:#{app.port}#{app.path}"
			ip: app.ip
			ipType: app.ipType

	console.log '---- infos: ', infos
	ctx.send 'hello word'



app.listen 3000