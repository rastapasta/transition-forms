`import Ember from 'ember'`

AnmeldungGruppeController = Ember.ObjectController.extend
	tage: [
		{id: 'mittwoch', value: 'Mittwoch, 26.8.', nurAnreise: true, nurHelfer: true}
		{id: 'freitag', value: 'Freitag, 28.8.'}
		{id: 'samstag', value: 'Samstag, 29.8.'}
		{id: 'sonntag', value: 'Sonntag, 30.8.'}
	]

	alter: (->
		for alter in [1...18]
			id: alter
			value: alter+' Jahr'+ if alter > 1 then "e" else ""
	).property()

	forwardDisabled: (->
		return true if @get('model.gruppe.length') < 3

		childWithoutAge = false
		@get('model.gruppe').forEach (person) ->
			return childWithoutAge = true if person.get('name') and not person.get('istErwachsen') and not person.get('alter')
		childWithoutAge
	).property 'model.gruppe.length', 'model.gruppe.@each.istErwachsen', 'model.gruppe.@each.alter'

	hilfeClass: (->
		'darkred' if @get('model.bucher.gruppeHilft') and @get('model.bucher.gruppeReist')
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

	gruppeHatKind: (->
		hatKind = false
		@get('model.gruppe').forEach (person) ->
			hatKind = true unless person.get('istErwachsen')
				
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

`export default AnmeldungGruppeController`