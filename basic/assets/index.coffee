GridFw = require '../../../gridfw'

app = new GridFw()

app.get '/', (ctx) ->
	ctx.send 'hello word'



app.listen 3000