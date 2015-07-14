`import Ember from 'ember'`

BeitragOption = Ember.Component.extend
	classNameBindings: ['isActive', 'isDisabled']
	classNames: ['blink']

	actions:
		slided: (v) ->
			@set 'beitrag.flexiblerPreis', Math.floor v

	isDisabled: (->
		true
	).property()

	heartStyle: (->
		red = Math.floor 255*(@get('beitrag.aktuellerPreis')-70)/180
		"color:rgb(#{red},0,0);"
	).property 'beitrag.aktuellerPreis'

	isActive: (->
		@get('current') is @get('beitrag.id')
	).property 'current'

	showSlider: (->
		@get('beitrag.istFlexibel') and @get('isActive')
	).property 'isActive'

`export default BeitragOption`
