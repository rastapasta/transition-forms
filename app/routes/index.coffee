`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
	model: ->
		bucher: @store.find 'person', 1
		gruppe: @store.find 'person'



`export default IndexRoute`
