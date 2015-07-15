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

  unterkunft: DS.belongsTo 'unterkunft', async: true,  inverse: false
  unterkunftMit: DS.hasMany 'person', inverse: 'schlaeftBei'
  schlaeftBei: DS.belongsTo 'person', inverse: 'unterkunftMit'

  anreise: DS.attr 'string'
  abreise: DS.attr 'string'

  beitrag: DS.belongsTo 'beitrag', async: true, inverse: false

  istInGruppe: (->
  	@get('istGruppe') or @get('id') isnt '1'
  ).property 'id', 'istGruppe'

  vorname: (->
  	@get('name').split(' ')[0]
  ).property 'name'

  nachname: (->
  	parts = @get('name').split ' '
  	parts[parts.length-1]
  ).property 'name'

  shortname: (->
  	@get('vorname')+' '+@get('nachname').charAt(0).toUpperCase()+'.'
  ).property 'name'

Person.reopenClass
	FIXTURES: [{
		id: 1
		istBucher: true
		name: 'Alex Bert'
		initiative: 'Transition Musterstadt'
		strasse: 'Maximilianstrasse'
		hausnummer: '1'
		plz: '12345'
		ort: 'Musterstadt'
		land: 'Deutschland'
		email: 'test@test.de'
		telefon: '0123 - 12345'
		beitrag: 'normal'
		unterkunft: 'doppelzimmer'
		unterkunftMit: ['a']
		istGruppe: true
	},{
		id: 'a'
		name: 'Kim Dreit'
		beitrag: 'soli'
	},{
		id: 'b'
		name: 'Anna Janna'
		beitrag: 'soli'
		unterkunft: 'wohnmobil'
	},{
		id: 'c'
		name: ''
	}]

`export default Person`
