`import Ember from 'ember'`

AnmeldungZusammenfassungController = Ember.Controller.extend
	tage:
		'26.08.': 0
		'28.08.': 2
		'29.08.': 3
		'30.08.': 4

	sent: false
	beitraege: (->
		mix = {}
		@get('model.gruppe').forEach (person) ->
			return unless beitrag = person.get 'beitrag'
			
			id = beitrag.get 'id'
			
			mix[id] ||=
				beitrag: beitrag
				summe: 0
				count: 0
				personen: []
				preis: beitrag.get 'aktuellerPreis'
				name: beitrag.get 'name'
			
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

			dateSource = if person.get('istInGruppe') and first.get('gruppeReist') then first else person
			anreise = dateSource.get('anreise')
			abreise = dateSource.get('abreise')

			person.get('unterkunftMit').forEach (person) =>
				unless first.get('gruppeReist')
					an = person.get('anreise')
					ab = person.get('abreise')
					anreise = an if an and @tage[an] < @tage[anreise]
					abreise = ab if ab and @tage[ab] > @tage[abreise]

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
				id: unterkunft.get 'id'
				name: unterkunft.get 'name'
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

	generateMail: ->
		text = "Liebe Michelle, liebe Vanny,\n
\n
ihr habt soeben folgende Anmeldung erhalten:\n
\n
  #{@get 'model.bucher.name'}\n
  #{@get 'model.bucher.strasse'} #{@get('model.bucher.hausnummer')}\n
  #{@get 'model.bucher.plz'} #{@get('model.bucher.ort')}\n
  #{@get 'model.bucher.land'}\n
  \n
  E-Mail: #{@get 'model.bucher.email'}\n
  Telefon: #{@get 'model.bucher.telefon'}\n
  \n
  Initiative: #{@get 'model.bucher.initiative'}\n
		"
		if @get 'model.bucher.willBetreuen'
			text += "\n
  [ X ] Würde sich gerne zwecks Kinderbetreuung vernetzen\n
			"

		text += "\n
  Personen\n
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n
		"
		for beitrag in @get 'beitraege'
			for person in beitrag.personen
				anreise = person.get if person.get 'parent.gruppeReist' then 'parent.anreise' else 'anreise'
				abreise = person.get if person.get 'parent.gruppeReist' then 'parent.abreise' else 'abreise'
				text += "  #{anreise} -> #{abreise} - #{person.get 'name'}"
				unless person.get 'istErwachsen'
					text += " - Kind, #{person.get 'alter'} Jahre"
				if person.get 'willHelfen'
					text += " - Helfer*in!"
				text += " - #{beitrag.name.split('(')[0]}"

				if beitrag.preis > 0
					text += " - #{beitrag.preis} Euro"

				text += "\n"

		unterkuenfte = @get 'unterkuenfte'
		if unterkuenfte.get 'length'
			text += "\n
  Unterkünfte\n
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n
			"

		for unterkunft in @get 'unterkuenfte'

			if unterkunft.id is 'keine'
				text += "  #{unterkunft.personen[0].get 'name'} organisiert seine eigene Unterkunft\n"
				continue

			text += "  #{unterkunft.name} - #{unterkunft.anreise} -> #{unterkunft.abreise}\n"

			if unterkunft.personen.length > 1
				text += "  im Zimmer: "
				text += (person.get 'name' for person in unterkunft.personen).join ', '
				text += "\n"

			else if @get 'model.bucher.istGruppe'
				text += "  für: #{unterkunft.personen[0].get 'name'}\n"

			text += "  #{unterkunft.count} #{if unterkunft.count > 1 then "Nächte" else "Nacht"} "
			if unterkunft.umsonstWeilHelfer
				text += "- kostenlos (Helfer*in)"
			else if unterkunft.umsonstWeilKind
				text += "- kostenlos (Kind)"
			else
				text += "á #{unterkunft.preis} -> #{unterkunft.summe} Euro"

			text += "\n"

		text += "\n
  Gesamtkosten\n
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n
    #{@get 'summe'} Euro
		"

		text

	generateTitle: ->
		"[Anmeldung] #{@get 'model.bucher.name'}#{if @get('model.gruppe.length') > 1 then " - #{@get('model.gruppe.length')} Personen" else ""}"
	
	actions:
		anmelden: ->
			$.ajax
				url: 'https://www.transition-regensburg.de/netzwerktreffen/mail.php'
				dataType: 'jsonp'
				data:
					title: @generateTitle()
					text: @generateMail()
				success: (data) =>
					@set 'sent', true

`export default AnmeldungZusammenfassungController`