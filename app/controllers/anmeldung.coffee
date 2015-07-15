`import Ember from 'ember'`

AnmeldungController = Ember.Controller.extend
	gruppenChange: (->
		switch @get 'model.istGruppe'
			when true then @transitionToRoute 'anmeldung.zusammenfassung' #gruppe
			when false then @transitionToRoute 'anmeldung.person.beitrag', 1
	).observes 'model.istGruppe'

`export default AnmeldungController`