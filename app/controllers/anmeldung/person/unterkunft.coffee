`import Ember from 'ember'`

AnmeldungPersonUnterkunftController = Ember.ObjectController.extend
	forwardDisabled: (->
		if @get('model.person.unterkunft') then null else true
	).property 'model.person.unterkunft'

`export default AnmeldungPersonUnterkunftController`