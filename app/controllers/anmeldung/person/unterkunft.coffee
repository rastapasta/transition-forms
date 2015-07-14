`import Ember from 'ember'`

AnmeldungPersonUnterkunftController = Ember.ObjectController.extend
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

`export default AnmeldungPersonUnterkunftController`