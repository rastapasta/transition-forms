`import Ember from 'ember'`

AnmeldungPersonBeitragRoute = Ember.Route.extend
	model: ->
		Ember.RSVP.hash
			person: @store.find 'person', @paramsFor('anmeldung.person').person_id
			beitraege: @store.find 'beitrag'		

`export default AnmeldungPersonBeitragRoute`
