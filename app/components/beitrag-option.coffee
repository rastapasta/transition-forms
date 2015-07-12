`import Ember from 'ember'`

BeitragOption = Ember.Component.extend
	classNameBindings: ['isActive']

	actions:
		slided: (v) ->
			@set 'beitrag.flexiblerPreis', Math.floor v

	isActive: (->
		@get('current') is @get('beitrag.id')
	).property 'current'

	showSlider: (->
		@get('beitrag.istFlexibel') and @get('isActive')
	).property 'isActive'

`export default BeitragOption`
