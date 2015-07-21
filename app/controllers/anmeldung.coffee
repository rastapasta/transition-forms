`import Ember from 'ember'`

AnmeldungController = Ember.Controller.extend
	validates: (->
		return false unless person = @get 'model.person'

		for key in ['name', 'strasse', 'hausnummer', 'plz', 'ort', 'land', 'email', 'telefon']
			return false if not person.get key
		true
	).property 'model.person.name', 'model.person.strasse', 'model.person.hausnummer', 'model.person.plz', 'model.person.ort', 'model.person.land', 'model.person.email', 'model.person.telefon'

	forwardDisabled: Ember.computed.not 'validates'

	gruppenChange: (->
		switch @get 'model.person.istGruppe'
			when true then @transitionToRoute 'anmeldung.gruppe'
			when false
				@get('model.gruppe').forEach (p) ->
					p.deleteRecord() if p.get('id') isnt '1'
				@set 'model.person.gruppeHilft', false
				@set 'model.person.unterkunftMit', []
				@transitionToRoute 'anmeldung.person.anreise', 1
	).observes 'model.person.istGruppe'

`export default AnmeldungController`