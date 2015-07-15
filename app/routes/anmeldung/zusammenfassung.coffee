`import Ember from 'ember'`

AnmeldungZusammenfassungRoute = Ember.Route.extend
	model: ->
		bucher: @store.find 'person', 1
		gruppe: @store.find 'person'

`export default AnmeldungZusammenfassungRoute`
