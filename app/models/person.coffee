`import DS from 'ember-data'`

Person = DS.Model.extend {
  name: DS.attr 'string'
  initiative: DS.attr 'string'
  strasse: DS.attr 'string'
  plz: DS.attr 'string'
  ort: DS.attr 'string'
  land: DS.attr 'string'
  email: DS.attr 'string'
  telefon: DS.attr 'string'
}

`export default Person`
