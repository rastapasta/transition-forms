`import Ember from 'ember'`

AnmeldungZusammenfassungController = Ember.Controller.extend
	tage:
		'26.08.': 0
		'28.08.': 2
		'29.08.': 3
		'30.08.': 4

	beitraege: (->
		mix = {}
		@get('model.gruppe').forEach (person) ->
			return unless beitrag = person.get 'beitrag'
			
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
		first = null
		@get('model.gruppe').forEach (person) =>
			first ||= person
			return if person.get('schlaeftBei')

			unterkunft = person.get 'unterkunft'
			return if not unterkunft or not unterkunft.get('id')
			
			personen = [person]

			if person.get('istInGruppe') and first.get('gruppeReist')
				anreise = first.get('anreise')
				abreise = first.get('abreise')
			else
				anreise = person.get('anreise')
				abreise = person.get('abreise')

			person.get('unterkunftMit').forEach (person) =>
				unless first.get('gruppeReist')
					an = person.get('anreise')
					ab = person.get('abreise')
					anreise = an if @tage[an] < @tage[anreise]
					abreise = ab if @tage[ab] > @tage[abreise]

				personen.push person

			naechte = @tage[abreise]-@tage[anreise]

			preis = unterkunft.get('preis')

			umsonstWeilKind = unterkunft.get('umsonstFuerKinder') and not person.get('istErwachsen')
			umsonstWeilHelfer = unterkunft.get('umsonstFuerHelfer') and person.get('willHelfen')
			
			preis = 0 if umsonst = (umsonstWeilKind or umsonstWeilHelfer)


			mix.push
				count: naechte
				personen: personen
				unterkunft: unterkunft
				summe: naechte*preis
				preis: preis
				umsonstWeilKind: umsonstWeilKind
				umsonstWeilHelfer: umsonstWeilHelfer
				umsonst: umsonst
				anreise: anreise
				abreise: abreise

		mix
	).property 'model.gruppe.@each.unterkunft'

	summe: (->
		summe = 0
		summe += unterkunft.summe for unterkunft in @get('unterkuenfte')
		summe += beitrag.summe for beitrag in @get('beitraege')
		summe
	).property 'unterkuenfte', 'beitraege'

`export default AnmeldungZusammenfassungController`