`import DS from 'ember-data'`

Person = DS.Model.extend
  name: DS.attr 'string'
  initiative: DS.attr 'string'
  strasse: DS.attr 'string'
  plz: DS.attr 'string'
  ort: DS.attr 'string'
  land: DS.attr 'string'
  email: DS.attr 'string'
  telefon: DS.attr 'string'

  alter: DS.attr 'number'

  istErwachsen: DS.attr 'boolean', defaultValue: true
  istBucher: DS.attr 'boolean', defaultValue: false
  istGruppe: DS.attr 'boolean'

  uebernachtung: DS.attr 'string'

Person.reopenClass
	FIXTURES: [{
		id: 1
		istBucher: true
		name: 'Maxi Musterfrau'
	}]

`export default Person`
