var GridFw, app;

GridFw = require('../../../gridfw');

app = new GridFw();

app.get('/', function(ctx) {
  return ctx.send('hello word');
});

app.listen(3000);
