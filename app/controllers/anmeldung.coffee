`import Ember from 'ember'`

AnmeldungController = Ember.Controller.extend
	gruppenChange: (->
		switch @get 'model.person.istGruppe'
			when true then @transitionToRoute 'anmeldung.gruppe'
			when false then @transitionToRoute 'anmeldung.person.beitrag', 1
	).observes 'model.person.istGruppe'

`export default AnmeldungController`