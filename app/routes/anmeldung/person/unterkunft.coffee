`import Ember from 'ember'`

AnmeldungPersonUnterkunftRoute = Ember.Route.extend
	model: ->
		Ember.RSVP.hash
			person: @store.find 'person', @paramsFor('anmeldung.person').person_id
			unterkuenfte: @store.find 'unterkunft'

`export default AnmeldungPersonUnterkunftRoute`
