`import Ember from 'ember'`

AnmeldungController = Ember.Controller.extend
	gruppenChange: (->
		switch @get 'model.person.istGruppe'
			when true then @transitionToRoute 'anmeldung.gruppe'
			when false
				@get('model.gruppe').forEach (p) ->
					p.deleteRecord() if p.get('id') isnt '1'
				@store.createRecord 'person'
				@transitionToRoute 'anmeldung.person.beitrag', 1
	).observes 'model.person.istGruppe'

`export default AnmeldungController`