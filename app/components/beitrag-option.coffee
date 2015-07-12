`import Ember from 'ember'`

BeitragOption = Ember.Component.extend
	classNameBindings: ['isActive']
	classNames: ['blink']

	actions:
		slided: (v) ->
			@set 'beitrag.flexiblerPreis', Math.floor v

	heartStyle: (->
		ratio = (250-@get('beitrag.aktuellerPreis'))/180

		red = 255-Math.floor(255*ratio)
		"color:rgb(#{red},0,0);"
	).property 'beitrag.aktuellerPreis'

	isActive: (->
		@get('current') is @get('beitrag.id')
	).property 'current'

	showSlider: (->
		@get('beitrag.istFlexibel') and @get('isActive')
	).property 'isActive'

`export default BeitragOption`
