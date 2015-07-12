`import Ember from 'ember'`

UnterkunftOption = Ember.Component.extend
	classNameBindings: ['isActive']
	isActive: (->
		@get('current') is @get('unterkunft.id')
	).property 'current'

`export default UnterkunftOption`