`import Ember from 'ember'`

BeitragOption = Ember.Component.extend
	classNameBindings: ['isActive', 'isDisabled']
	classNames: ['blink']

	actions:
		slided: (v) ->
			@set 'beitrag.flexiblerPreis', Math.floor v

	isDisabled: (->
		if @get('beitrag.preis') is 0
			if @get('canBeFree') then false else true
		else
			if @get('canBeFree') then true else false
	).property 'canBeFree'

	heartStyle: (->
		red = Math.floor 255*(@get('beitrag.aktuellerPreis')-70)/180
		"color:rgb(#{red},0,0);"
	).property 'beitrag.aktuellerPreis'

	isActive: (->
		@get('person.beitrag') is @get('beitrag')
	).property 'person.beitrag'

	showSlider: (->
		@get('beitrag.istFlexibel') and @get('isActive')
	).property 'isActive'

`export default BeitragOption`
