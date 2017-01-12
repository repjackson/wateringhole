Template.person.events
    'click .person_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()
        
# Template.person.helpers
#     tag_class: -> if @valueOf() in selected_tags.array() then 'blue' else 'basic'

#     # eco_tags: ->
#     #     _.without(@tags, 'ecosystem') 
