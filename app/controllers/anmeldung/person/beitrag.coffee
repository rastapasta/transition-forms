`import Ember from 'ember'`

AnmeldungPersonBeitragController = Ember.Controller.extend
	canBeFree: (->
		@get('model.person.willHelfen') or not @get('model.person.istErwachsen')
	).property 'model.person.istErwachsen', 'model.person.willHelfen'

	forwardDisabled: Ember.computed.empty 'model.person.beitrag'

`export default AnmeldungPersonBeitragController`
