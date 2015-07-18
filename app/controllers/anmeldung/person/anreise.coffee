`import Ember from 'ember'`

AnmeldungPersonAnreiseController = Ember.Controller.extend
	tage: [
		{id: '26.08.', value: 'Mittwoch, 26.8.', nurAnreise: true, nurHelfer: true}
		{id: '28.08.', value: 'Freitag, 28.8.'}
		{id: '29.08.', value: 'Samstag, 29.8.'}
		{id: '30.08.', value: 'Sonntag, 30.8.'}
	]

	# TODO: omg...... <shame> will handle better later, let's get the MVP up first ;)
	fridayClass: (-> if not @get('model.person.anreise') or @get('model.person.anreise') is '28.08.' then 'highlight' else '').property 'model.person.anreise'
	saturdayClass: (-> if not @get('model.person.anreise') or @get('model.person.anreise') is '29.08.' then 'highlight' else '').property 'model.person.anreise'
	sundayClass: (-> if not @get('model.person.anreise') or @get('model.person.anreise') is '30.08.' then 'highlight' else '').property 'model.person.anreise'

	kannHelfen: (->
		@get('model.person.istErwachsen') and
		(@get('model.person.gruppeHilft') or @get('model.person.parent.gruppeHilft')) or
		(@get('model.person.id') is '1' and not @get('model.person.istInGruppe'))
	).property 'model.person.istErwachsen', 'model.person.gruppeHilft', 'model.person.parent.gruppeHilft', 'model.person.id', 'model.person.istInGruppe'

	zeigeAnreise: (->
		not @get('model.person.istInGruppe') or not @get('model.person.reistGruppeZusammen')
	).property 'model.person.istInGruppe', 'model.person.reistGruppeZusammen'

	willHelfen: (->
		if @get 'model.person.willHelfen'
			@set 'model.person.anreise', '26.08.'

			@store.find('beitrag', 'kostenlos').then (beitrag) =>
				@set 'model.person.beitrag', beitrag

		else if @get('model.person.anreise') is '26.08.'
			@set 'model.person.anreise', undefined
			@set 'model.person.beitrag', undefined
	).observes 'model.person.willHelfen'

	abreiseAmSonntag: (->
		if @get('model.person.anreise') is '30.08.' 
			@set 'model.person.abreise', '30.08.'
	).observes 'model.person.anreise'

	hilfeClass: (->
		'darkred' if @get('model.person.willHelfen')
	).property 'model.person.willHelfen'

	canGoBack: Ember.computed.alias 'model.person.istInGruppe'

	forwardDisabled: (->
		if @get('model.person.gruppeReist') or @get('model.person.parent.gruppeReist')
			return false
		else if not @get('model.person.anreise') or not @get('model.person.abreise')
			return true
		else
			false
	).property 'model.person.anreise', 'model.person.abreise', 'model.person.gruppeReist', 'model.person.parent.gruppeReist'

	anreiseTage: (->
		tag for tag in @tage when not tag.nurHelfer or @get('model.person.willHelfen')
	).property 'model.person.willHelfen'

	abreiseTage: (->
		anreise = @get 'model.person.anreise'
		found = false
		tag for tag in @tage when (found ||= anreise is tag.id) and not tag.nurAnreise
	).property 'model.person.anreise'

`export default AnmeldungPersonAnreiseController`
