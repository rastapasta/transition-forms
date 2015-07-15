`import Ember from 'ember'`

UnterkunftOption = Ember.Component.extend
	classNameBindings: ['isActive']
	isActive: (->
		@get('person.unterkunft') is @get('unterkunft')
	).property 'person.unterkunft'

	maxPax: (->
		@get('unterkunft.plaetze')-1
	).property 'unterkunft'

`export default UnterkunftOption`