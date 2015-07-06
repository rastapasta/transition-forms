/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp({
  'ember-cli-selectize': {
    //valid values are `default`, `bootstrap2`, `bootstrap3` or false
    'theme': 'bootstrap3'
  }
});
app.import(app.bowerDirectory + '/bootstrap/dist/js/bootstrap.js');
app.import(app.bowerDirectory + '/bootstrap/dist/css/bootstrap.css');
app.import(app.bowerDirectory + '/bootstrap/dist/fonts/glyphicons-halflings-regular.woff', {destDir: 'fonts'});
app.import(app.bowerDirectory + '/bootstrap/dist/fonts/glyphicons-halflings-regular.woff2', {destDir: 'fonts'});
module.exports = app.toTree();
