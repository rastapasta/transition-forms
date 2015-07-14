`import Ember from 'ember'`

AnmeldungController = Ember.ObjectController.extend
	gruppenChange: (->
		switch @get 'model.istGruppe'
			when true then @transitionToRoute 'anmeldung.gruppe'
			when false then @transitionToRoute 'anmeldung.person.beitrag', 1
	).observes 'model.istGruppe'

`export default AnmeldungController`