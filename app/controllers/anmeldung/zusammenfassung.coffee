`import Ember from 'ember'`

AnmeldungZusammenfassungController = Ember.Controller.extend
	beitraege: (->
		mix = {}
		@get('model.gruppe').forEach (person) ->
			beitrag = person.get 'beitrag'
			id = beitrag.get 'id'
			
			mix[id] ||= beitrag: beitrag, summe: 0, count: 0
			
			mix[id].personen ||= []
			mix[id].personen.push person

			mix[id].count++
			mix[id].summe += beitrag.get 'aktuellerPreis'

		beitrag for beitrag in mix
	).property 'model.gruppe.@each.beitrag'

`export default AnmeldungZusammenfassungController`