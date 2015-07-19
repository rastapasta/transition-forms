`import Ember from 'ember'`

AnmeldungController = Ember.Controller.extend
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