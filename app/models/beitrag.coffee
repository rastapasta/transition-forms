`import DS from 'ember-data'`

Beitrag = DS.Model.extend
	name: DS.attr 'string'
	istReduziert: DS.attr 'boolean'
	istHelfer: DS.attr 'boolean'
	preis: DS.attr 'number'

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
		preis: 70
	},{
		id: 'helfer'
		name: 'Kostenlos (für Helfer*innen)'
		istHelfer: true
		preis: 0
	}]

`export default Beitrag`
