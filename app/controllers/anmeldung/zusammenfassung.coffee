`import Ember from 'ember'`

AnmeldungZusammenfassungController = Ember.Controller.extend
	beitraege: (->
		
	).property 'model.gruppe.@each.beitrag'

`export default AnmeldungZusammenfassungController`