`import Ember from 'ember'`

AnmeldungZusammenfassungController = Ember.Controller.extend
	beitraege: (->
		mix = {}
		@get('model.gruppe').forEach (person) ->
			beitrag = person.get 'beitrag'
			return unless beitrag and person.get('name')
			
			id = beitrag.get 'id'
			
			mix[id] ||= beitrag: beitrag, summe: 0, count: 0
			
			mix[id].personen ||= []
			mix[id].personen.push person

			mix[id].count++
			mix[id].multiple = mix[id].count > 1
			
			mix[id].summe += beitrag.get 'aktuellerPreis'

		beitrag for k,beitrag of mix
	).property 'model.gruppe.@each.beitrag'

	unterkuenfte: (->
		mix = []
		@get('model.gruppe').forEach (person) ->
			return if person.get('schlaeftBei')

			unterkunft = person.get 'unterkunft'
			return if not unterkunft or not unterkunft.get('id') or not person.get('name')
			
			personen = [person]
			person.get('unterkunftMit').forEach (person) ->
				personen.push person

			mix.push
				count: 3
				personen: personen
				unterkunft: unterkunft
				summe: 3*unterkunft.get('preis')

		mix
	).property 'model.gruppe.@each.unterkunft'

	summe: (->
		summe = 0
		summe += unterkunft.summe for unterkunft in @get('unterkuenfte')
		summe += beitrag.summe for beitrag in @get('beitraege')
		summe
	).property 'unterkuenfte', 'beitraege'

`export default AnmeldungZusammenfassungController`