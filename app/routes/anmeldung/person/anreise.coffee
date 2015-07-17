`import Ember from 'ember'`

AnmeldungPersonAnreiseRoute = Ember.Route.extend
	model: ->
		Ember.RSVP.hash
			person: @store.find 'person', @paramsFor('anmeldung.person').person_id

`export default AnmeldungPersonAnreiseRoute`
