`import Ember from 'ember'`

AnmeldungGruppeController = Ember.Controller.extend
	tage: [
		{id: '26.08.', value: 'Mittwoch, 26.8.', nurAnreise: true, nurHelfer: true}
		{id: '28.08.', value: 'Freitag, 28.8.'}
		{id: '29.08.', value: 'Samstag, 29.8.'}
		{id: '30.08.', value: 'Sonntag, 30.8.'}
	]

	alter: (->
		for alter in [1...18]
			id: alter
			value: alter+' Jahr'+ if alter > 1 then "e" else ""
	).property()

	forwardDisabled: (->
		return true if @get('model.gruppe.length') < 3
		return true if @get('model.bucher.gruppeReist') and (not @get('model.bucher.anreise') or not @get('model.bucher.abreise'))

		childWithoutAge = false
		@get('model.gruppe').forEach (person) ->
			return childWithoutAge = true if person.get('name') and not person.get('istErwachsen') and not person.get('alter')
		childWithoutAge
	).property 'model.gruppe.length', 'model.gruppe.@each.istErwachsen', 'model.gruppe.@each.alter', 'model.bucher.gruppeReist', 'model.bucher.anreise', 'model.bucher.abreise'

	hilfeClass: (->
		'darkred' if @get('model.bucher.gruppeHilft') and @get('model.bucher.gruppeReist')
	).property 'model.bucher.gruppeHilft', 'model.bucher.gruppeReist'

	gruppeHilft: (->
		if @get 'model.bucher.gruppeHilft'
			@set 'model.bucher.anreise', '26.08.'
		else if @get('model.bucher.anreise') is '26.08'
			@set 'model.bucher.anreise', undefined
	).observes 'model.bucher.gruppeHilft'

	erwachsenChange: (->
		@get('model.gruppe').forEach (person) =>
			if person.get('istErwachsen')
				if person.get('beitrag.id') is 'kostenlos'
					person.set 'beitrag', undefined
			else
				if person.get('beitrag.id') isnt 'kostenlos'
					# TODO: that's such a dirty hack to avoid a race condition caused shuffling of the collection's order
					@store.find('beitrag').then =>
						@store.find('beitrag', 'kostenlos').then (beitrag) =>
							person.set 'beitrag', beitrag
	).observes 'model.gruppe.@each.istErwachsen'

	anreiseTage: (->
		tag for tag in @tage when not tag.nurHelfer or @get('model.bucher.gruppeHilft')
	).property 'model.bucher.gruppeHilft'

	abreiseTage: (->
		anreise = @get 'model.bucher.anreise'
		found = false
		tag for tag in @tage when (found ||= anreise is tag.id) and not tag.nurAnreise
	).property 'model.bucher.anreise'

	abreiseAmSonntag: (->
		if @get('model.bucher.anreise') is '30.08.' 
			@set 'model.bucher.abreise', '30.08.'
	).observes 'model.bucher.anreise'

	gruppeHatKind: (->
		hatKind = false
		@get('model.gruppe').forEach (person) ->
			hatKind = true unless person.get('istErwachsen')
				
		hatKind
	).property 'model.gruppe.@each.istErwachsen'

	actions:
		updateGruppe: ->
			oneEmpty = false
			@get('model.gruppe').forEach (person) ->
				unless person.get('name')
					if oneEmpty
						person.deleteRecord()
					else
						oneEmpty = true

			unless oneEmpty
				@store.createRecord 'person', parent: @get('model.bucher')

`export default AnmeldungGruppeController`