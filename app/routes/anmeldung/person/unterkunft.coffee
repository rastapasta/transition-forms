`import Ember from 'ember'`

AnmeldungPersonUnterkunftRoute = Ember.Route.extend
	model: ->
		Ember.RSVP.hash
			person: @store.find 'person', @paramsFor('anmeldung.person').person_id
			gruppe: @store.find 'person'
			unterkuenfte: @store.find 'unterkunft'

`export default AnmeldungPersonUnterkunftRoute`
