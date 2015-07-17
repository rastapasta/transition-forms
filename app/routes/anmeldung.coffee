`import Ember from 'ember'`

AnmeldungRoute = Ember.Route.extend
	model: ->
		Ember.RSVP.hash
			person: @store.find 'person', 1
			gruppe: @store.find 'person'

	getNextId: (id, backwards) ->
		gruppe = @modelFor('anmeldung').gruppe
		count = gruppe.get 'length'
		for i in [0...count]
			if gruppe.objectAt(i).get('id') is id
				return null if (backwards and i is 0) or (not backwards and i is count-1)
				return gruppe.objectAt(if backwards then i-1 else i+1).get 'id'

	canSeeUnterkunft: (id, yesCb, noCb) ->
		@store.find('person', id).then (person) =>
			if person.get('schlaeftBei')
				noCb()
			else
				yesCb()

	actions:
		next: (current, id) ->
			switch current
				when "gruppe"
					@transitionTo "anmeldung.person.anreise", 1
				when "anreise"
					@transitionTo "anmeldung.person.beitrag", id
				when "beitrag"
					@canSeeUnterkunft id,
						=> @transitionTo "anmeldung.person.unterkunft", id
						=> @send "next", "unterkunft", id
				when "unterkunft"
					if nextId = @getNextId id
						@transitionTo "anmeldung.person.beitrag", nextId
					else
						@transitionTo "anmeldung.zusammenfassung"

		back: (current, id) -> 
			switch current
				when "beitrag"
					if previous = @getNextId id, true
						@canSeeUnterkunft previous,
							=> @transitionTo "anmeldung.person.unterkunft", previous
							=> @send "back", "unterkunft", previous
					else
						@transitionTo "anmeldung.gruppe"
				when "unterkunft"
					@transitionTo "anmeldung.person.beitrag", id

				when "zusammenfassung"
					gruppe = @modelFor('anmeldung').gruppe
					previous = gruppe.objectAt(gruppe.get('length')-1).get('id')

					@canSeeUnterkunft previous,
						=> @transitionTo "anmeldung.person.unterkunft", previous
						=> @send "back", "unterkunft", previous

`export default AnmeldungRoute`
