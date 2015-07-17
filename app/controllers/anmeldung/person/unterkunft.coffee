`import Ember from 'ember'`

AnmeldungPersonUnterkunftController = Ember.Controller.extend
	forwardDisabled: (->
		if @get('model.person.unterkunft') then null else true
	).property 'model.person.unterkunft'

	unterkuenfte: (->
		mitglieder = @get('cosleepingOptionen').length

		unterkuenfte = []
		@get('model.unterkuenfte').forEach (unterkunft) =>
			plaetze = unterkunft.get 'plaetze'

			if plaetze is 1 or mitglieder >= (plaetze-1)
				unterkuenfte.push unterkunft
		unterkuenfte
	).property 'model.unterkuenfte.[]'

	cosleepingOptionen: (->
		personen = []
		currentId = @get('model.person.id')
		@get('model.gruppe').forEach (person) =>
			return if person.get('id') is @get('model.person.id')
			if person.get('id') > currentId and (not person.get('schlaeftBei') or person.get('schlaeftBei.id') is currentId or person.get('schlaeftBei.id') > currentId)
				personen.push person
		personen
	).property 'model.gruppe.@each.unterkunft'

	cosleepingReset: (->
		if @get('model.person.unterkunftMit.length') > @get('model.person.unterkunft.plaetze')-1
			@set 'model.person.unterkunftMit', []
	).observes 'model.person.unterkunft'

`export default AnmeldungPersonUnterkunftController`