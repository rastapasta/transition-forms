`import Ember from 'ember'`

UnterkunftOption = Ember.Component.extend
	classNameBindings: ['isActive']
	isActive: (->
		@get('person.unterkunft') is @get('unterkunft')
	).property 'person.unterkunft'

	isFree: (->
		(@get('unterkunft.umsonstFuerHelfer') and @get('person.willHelfen')) or
		(@get('unterkunft.umsonstFuerKinder') and not @get('person.istErwachsen'))
	).property 'unterkunft.umsonstFuerHelfer', 'unterkunft.umsonstFuerKinder', 'person.istErwachsen', 'person.willHelfen'

	maxPax: (->
		@get('unterkunft.plaetze')-1
	).property 'unterkunft'

`export default UnterkunftOption`