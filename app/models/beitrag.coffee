`import DS from 'ember-data'`

Beitrag = DS.Model.extend
	name: DS.attr 'string'
	istReduziert: DS.attr 'boolean'
	istHelfer: DS.attr 'boolean'
	istFlexibel: DS.attr 'boolean'
	preis: DS.attr 'number'
	flexiblerPreis: DS.attr 'number', defaultValue: 70

	aktuellerPreis: (->
		if @get 'istFlexibel'
			@get 'flexiblerPreis'
		else
			@get 'preis'
	).property 'flexiblerPreis'

	individualPreis: (->
		@get('flexiblerPreis') > @get('preis') 
	).property 'flexiblerPreis'

Beitrag.reopenClass
	FIXTURES: [{
		id: 'ermaessigt'
		name: 'Ermäßigter Preis'
		istReduziert: true
		preis: 30
	},{
		id: 'normal'
		name: 'Normaler Preis'
		preis: 50
	},{
		id: 'soli'
		name: 'Solipreis'
		istFlexibel: true
		preis: 70
	},{
		id: 'helfer'
		name: 'Kostenlos (für Helfer*innen)'
		istHelfer: true
		preis: 0
	}]

`export default Beitrag`
