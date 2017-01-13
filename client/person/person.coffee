Template.person.onRendered ->
    $('.ui.accordion').accordion()



Template.person.events
    'click .person_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()
        
Template.person.helpers
    tag_class: -> if @valueOf() in selected_tags.array() then 'teal' else ''