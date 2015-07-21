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

  parent: DS.belongsTo 'person', inverse: 'childs'
  childs: DS.hasMany 'person', inverse: 'parent'

  istErwachsen: DS.attr 'boolean', defaultValue: true
  istBucher: DS.attr 'boolean', defaultValue: false
  
  gruppeReist: DS.attr 'boolean'
  gruppeHilft: DS.attr 'boolean'

  istGruppe: DS.attr 'boolean'
  willBetreuen: DS.attr 'boolean'
  willHelfen: DS.attr 'boolean'

  # TODO: when a booker moves back after having set all accomodations,
  #	make sure to remove followup cosleepings relations to avoid double-
  # relating one person to many unterkunftMit
  unterkunft: DS.belongsTo 'unterkunft', inverse: false
  unterkunftMit: DS.hasMany 'person', inverse: 'schlaeftBei'
  schlaeftBei: DS.belongsTo 'person', inverse: 'unterkunftMit'

  anreise: DS.attr 'string'
  abreise: DS.attr 'string'

  beitrag: DS.belongsTo 'beitrag', inverse: false

  istInGruppe: (->
  	@get('istGruppe') or @get('id') isnt '1'
  ).property 'id', 'istGruppe'

  reistGruppeZusammen: (->
  	@get('gruppeReist') or (@get('parent') and @get('parent.gruppeReist'))
  ).property 'gruppeReist', 'parent.gruppeReist'

  hilftGruppenmitglied: (->
  	@get('gruppeHilft') or (@get('parent') and @get('parent.gruppeHilft'))
  ).property 'gruppeHilft', 'parent.gruppeHilft'

Person.reopenClass
	FIXTURES: [{
		id: 1
		istBucher: true
	}]
	###
		name: 'Alex Bert'
		initiative: 'Transition Musterstadt'
		strasse: 'Maximilianstrasse'
		hausnummer: '1'
		plz: '12345'
		ort: 'Musterstadt'
		land: 'Deutschland'
		email: 'test@test.de'
		telefon: '0123 - 12345'
	###

`export default Person`
