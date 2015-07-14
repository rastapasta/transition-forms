`import Ember from 'ember'`

AnmeldungPersonBeitragController = Ember.ObjectController.extend
	canBeFree: (->
		@get('model.person.willHelfen') or not @get('model.person.istErwachsen')
	).property 'model.person.istErwachsen', 'model.person.willHelfen'

	canGoBack: (->
		@get('model.person.istGruppe') or @get('model.person.id') isnt '1'
	).property 'model.person.istGruppe', 'model.person.id'

`export default AnmeldungPersonBeitragController`
