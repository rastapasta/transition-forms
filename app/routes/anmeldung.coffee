`import Ember from 'ember'`

AnmeldungRoute = Ember.Route.extend
	model: ->
		@store.find 'person', 1

`export default AnmeldungRoute`
