`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
	location: config.locationType

Router.map ->
	@route 'anmeldung', path: '/', ->
		@route 'gruppe'

		@route 'person', path: '/person/:person_id', ->
			@route 'anreise'
			@route 'beitrag'
			@route 'unterkunft'

		@route 'zusammenfassung'

`export default Router`
