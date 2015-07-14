`import DS from 'ember-data'`

Person = DS.Model.extend
  name: DS.attr 'string'
  initiative: DS.attr 'string'
  strasse: DS.attr 'string'
  hausnummer: DS.attr 'string'
  plz: DS.attr 'string'
  ort: DS.attr 'string'
  land: DS.attr 'string'
  email: DS.attr 'string'
  telefon: DS.attr 'string'

  alter: DS.attr 'number'

  istErwachsen: DS.attr 'boolean', defaultValue: true
  istBucher: DS.attr 'boolean', defaultValue: false
  
  gruppeReist: DS.attr 'boolean'
  gruppeHilft: DS.attr 'boolean'

  istGruppe: DS.attr 'boolean'
  willBetreuen: DS.attr 'boolean'
  willHelfen: DS.attr 'boolean'

  unterkunft: DS.attr 'string'

  anreise: DS.attr 'string'
  abreise: DS.attr 'string'

  istInGruppe: (->
  	@get('istGruppe') or @get('id') isnt '1'
  ).property 'id', 'istGruppe'

Person.reopenClass
	FIXTURES: [{
		id: 1
		istBucher: true
		name: 'Maxi Musterfrau'
	},{
		id: 'fixture-0'
	}]

`export default Person`
