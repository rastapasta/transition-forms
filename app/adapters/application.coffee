`import DS from 'ember-data'`
Adapter = DS.FixtureAdapter.extend
	simulateRemoteResponse: false
	counter: 3
	generateIdForRecord: ->
  		"person-" + @counter++

`export default Adapter`