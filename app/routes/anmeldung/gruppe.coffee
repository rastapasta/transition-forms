`import Ember from 'ember'`

AnmeldungGruppeRoute = Ember.Route.extend
	model: ->
		bucher: @store.find 'person', 1
		gruppe: @store.find 'person'
	
	setupController: (controller, model) ->
		@_super controller, model
		controller.send 'updateGruppe'

	deactivate: ->
		@modelFor('anmeldung.gruppe').gruppe.forEach (person) ->
			person.deleteRecord() unless person.get('name')?

`export default AnmeldungGruppeRoute`
