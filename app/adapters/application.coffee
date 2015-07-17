`import DS from 'ember-data'`
Adapter = DS.FixtureAdapter.extend
	simulateRemoteResponse: false
	counter: 2
	generateIdForRecord: ->
  		@counter++

`export default Adapter`