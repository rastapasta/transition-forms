`import DS from 'ember-data'`

Unterkunft = DS.Model.extend
	name: DS.attr 'string'
	info: DS.attr 'string'
	plaetze: DS.attr 'number'
	preis: DS.attr 'number'
	achtung: DS.attr 'string'

	umsonstFuerKinder: DS.attr 'boolean', defaultValue: false
	umsonstFuerHelfer: DS.attr 'boolean', defaultValue: false

	moreThanOne: Ember.computed.gt 'plaetze', 1
	
Unterkunft.reopenClass
	FIXTURES: [{
		id: 'attac'
		name: 'attac- oder Nachbar-Villa'
		info: 'in Doppel- bis Mehrbettzimmern'
		plaetze: 1
		preis: 10
		achtung: 'Wir weisen darauf hin, dass die Duschmöglichkeiten begrenzt sind.<br/>
Bitte bringe Deine eigene Bettwäsche bzw. Schlafsack mit.'
		umsonstFuerHelfer: true
	},{
		id: 'einzelzimmer'
		name: 'Hotel-Einzelzimmer'
		plaetze: 1
		preis: 40
	},{
		id: 'doppelzimmer'
		name: 'Hotel-Doppelzimmer'
		plaetze: 2
		preis: 65
	},{
		id: 'dreibettzimmer'
		name: 'Hotel-Dreibettzimmer'
		plaetze: 3
		preis: 85
	},{
		id: 'vierbettzimmer'
		name: 'Hotel-Vierbettzimmer'
		plaetze: 4
		preis: 100
	},{
		id: 'zeltplatz'
		name: 'Zeltplatz'
		plaetze: 1
		preis: 5
		achtung: 'Wir weisen darauf hin, dass die Duschmöglichkeiten begrenzt sind.<br/>
Bitte sorge selbst für entsprechende Ausrüstung wie Zelt, Schlafsack usw.'
		umsonstFuerHelfer: true
		umsonstFuerKinder: true
	},{
		id: 'wohnmobil'
		name: 'Wohnmobil auf dem Parkplatz'
		plaetze: 1
		preis: 5
		achtung: 'Wir weisen darauf hin, dass die Duschmöglichkeiten begrenzt sind.'
		umsonstFuerHelfer: true
		umsonstFuerKinder: true
	},{
		id: 'keine'
		name: 'Ich organisiere die Übernachtung selbst'
		plaetze: 1
		preis: 0
	}]
`export default Unterkunft`
