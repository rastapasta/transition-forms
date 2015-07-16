`import Ember from 'ember'`

AnmeldungRoute = Ember.Route.extend
	model: ->
		Ember.RSVP.hash
			person: @store.find 'person', 1
			gruppe: @store.find 'person'
	actions:
		next: (current, id) ->
			switch current
				when "gruppe"
					@transitionTo "anmeldung.person.beitrag", 1
				when "beitrag"
					@transitionTo "anmeldung.person.unterkunft", id
				when "unterkunft"
					if nextId = @getNextId id
						@transitionTo "anmeldung.person.beitrag", nextId
					else
						@transitionTo "anmeldung.zusammenfassung"

		back: (current, id) -> 
			switch current
				when "beitrag"
					previous = @getNextId id, true
					if previous isnt null
						@transitionTo "anmeldung.person.unterkunft", previous
					else
						@transitionTo "anmeldung.gruppe"
				when "unterkunft"
					@transitionTo "anmeldung.person.beitrag", id

				when "zusammenfassung"
					gruppe = @modelFor('anmeldung').gruppe
					@transitionTo "anmeldung.person.unterkunft", gruppe.objectAt(gruppe.get('length')-2).get('id')

	getNextId: (id, backwards) ->
		gruppe = @modelFor('anmeldung').gruppe
		count = gruppe.get 'length'
		for i in [0...count]
			person = gruppe.objectAt(i)
			if person.get('id') is id
				return null if (backwards and i is 0) or (not backwards and i is count-2)
				return gruppe.objectAt(if backwards then i-1 else i+1).get 'id'

`export default AnmeldungRoute`
