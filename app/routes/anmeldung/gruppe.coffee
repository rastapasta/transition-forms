`import Ember from 'ember'`

AnmeldungGruppeRoute = Ember.Route.extend
	model: ->
		bucher: @store.find 'person', 1
		gruppe: @store.find 'person'

`export default AnmeldungGruppeRoute`
