`import Ember from 'ember'`

AnmeldungPersonAnreiseController = Ember.Controller.extend
	tage: [
		{id: 'mittwoch', value: 'Mittwoch, 26.8.', nurAnreise: true, nurHelfer: true}
		{id: 'freitag', value: 'Freitag, 28.8.'}
		{id: 'samstag', value: 'Samstag, 29.8.'}
		{id: 'sonntag', value: 'Sonntag, 30.8.'}
	]

	canGoBack: Ember.computed.alias 'model.person.istInGruppe'

	willHelfen: (->
		if @get 'model.person.willHelfen'
			@set 'model.person.anreise', 'mittwoch'
	).observes 'model.person.willHelfen'

	hilfeClass: (->
		'darkred' if @get('model.person.willHelfen')
	).property 'model.person.willHelfen'

	forwardDisabled: (->
		not @get('model.person.anreise') or not @get('model.person.abreise')
	).property 'model.person.anreise', 'model.person.abreise'
	anreiseTage: (->
		tag for tag in @tage when not tag.nurHelfer or @get('model.person.willHelfen')
	).property 'model.person.willHelfen'

	abreiseTage: (->
		anreise = @get 'model.person.anreise'
		found = false
		tag for tag in @tage when (found ||= anreise is tag.id) and not tag.nurAnreise
	).property 'model.person.anreise'

`export default AnmeldungPersonAnreiseController`
