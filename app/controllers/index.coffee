`import Ember from 'ember'`

IndexController = Ember.ObjectController.extend
	tage: [
		{id: 'mittwoch', value: 'Mittwoch, 26.8.', nurAnreise: true, nurHelfer: true}
		{id: 'freitag', value: 'Freitag, 28.8.'}
		{id: 'samstag', value: 'Samstag, 29.8.'}
		{id: 'sonntag', value: 'Sonntag, 30.8.'}
	]

	hilfeClass: (->
		if @get('model.bucher.gruppeHilft') and @get('model.bucher.gruppeReist')
			'darkred'
	).property 'model.bucher.gruppeHilft', 'model.bucher.gruppeReist'

	gruppeHilft: (->
		if @get 'model.bucher.gruppeHilft'
			@set 'model.bucher.anreise', 'mittwoch'
	).observes 'model.bucher.gruppeHilft'

	anreiseTage: (->
		tag for tag in @tage when not tag.nurHelfer or @get('model.bucher.gruppeHilft')
	).property 'model.bucher.gruppeHilft'

	abreiseTage: (->
		anreise = @get 'model.bucher.anreise'
		found = false
		tag for tag in @tage when (found ||= anreise is tag.id) and not tag.nurAnreise
	).property 'model.bucher.anreise'

	alter: [
		{id: 1, value: '1 Jahr'}
		{id: 2, value: '2 Jahre'}
		{id: 3, value: '3 Jahre'}
		{id: 4, value: '4 Jahre'}
		{id: 5, value: '5 Jahre'}
		{id: 6, value: '6 Jahre'}
		{id: 7, value: '7 Jahre'}
		{id: 8, value: '8 Jahre'}
		{id: 9, value: '9 Jahre'}
		{id: 10, value: '10 Jahre'}
		{id: 11, value: '11 Jahre'}
		{id: 12, value: '12 Jahre'}
		{id: 13, value: '13 Jahre'}
		{id: 14, value: '14 Jahre'}
		{id: 15, value: '15 Jahre'}
		{id: 16, value: '16 Jahre'}
		{id: 17, value: '17 Jahre'}
	]

	showUebernachtung: (->
		v = @get 'model.bucher.istGruppe'
		v is false
	).property 'model.bucher.istGruppe'

	gruppeHatKind: (->
		hatKind = false
		@get('model.gruppe').forEach (person) ->
			unless person.get('istErwachsen')
				hatKind = true
				return true
		hatKind
	).property 'model.gruppe.@each.istErwachsen'

	gruppenFelder: (->
		oneEmpty = false
		@get('model.gruppe').forEach (person) ->
			unless person.get('name')
				if oneEmpty
					person.deleteRecord()
				else
					oneEmpty = true

		unless oneEmpty
			@store.createRecord 'person'

	).observes 'model.gruppe.@each.name'

`export default IndexController`
