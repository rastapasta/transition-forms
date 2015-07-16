`import Ember from 'ember'`

AnmeldungPersonUnterkunftController = Ember.Controller.extend
	forwardDisabled: (->
		if @get('model.person.unterkunft') then null else true
	).property 'model.person.unterkunft'

	unterkuenfte: (->
		single = not @get('model.person.istGruppe') and @get('model.person.id') is '1'
		mitglieder = @get('model.gruppe.length')-1

		unterkuenfte = []
		@get('model.unterkuenfte').forEach (unterkunft) =>
			plaetze = unterkunft.get 'plaetze'
			unless (single and plaetze > 1) or plaetze > mitglieder
				unterkuenfte.push unterkunft
		unterkuenfte
	).property 'model.unterkuenfte.[]'

	cosleepingOptionen: (->
		personen = []
		@get('model.gruppe').forEach (person) =>
			return if person.get('name') is ""
			return if person.get('id') is @get('model.person.id')
			if person.get('id') > @get('model.person.id')
				personen.push person
		personen
	).property 'model.gruppe.@each.unterkunft'

	cosleepingReset: (->
		if @get('model.person.unterkunftMit.length') > @get('model.person.unterkunft.plaetze')-1
			@set 'model.person.unterkunftMit', []
	).observes 'model.person.unterkunft'

`export default AnmeldungPersonUnterkunftController`