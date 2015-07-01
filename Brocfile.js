/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();
app.import(app.bowerDirectory + '/bootstrap/dist/js/bootstrap.js');
app.import(app.bowerDirectory + '/bootstrap/dist/css/bootstrap.css');
module.exports = app.toTree();
