`import Ember from 'ember'`

AnmeldungPersonBeitragController = Ember.ObjectController.extend
	canBeFree: (->
		@get('model.person.willHelfen') or not @get('model.person.istErwachsen')
	).property 'model.person.istErwachsen', 'model.person.willHelfen'

	canGoBack: Ember.computed.alias 'model.person.istInGruppe'

	forwardDisabled: Ember.computed.empty 'model.person.beitrag'

`export default AnmeldungPersonBeitragController`
