if Meteor.isClient
    Template.people.onCreated ->
        @autorun -> Meteor.subscribe('people', selected_tags.array())
    
    
    Template.people.helpers
        people: -> 
            Meteor.users.find { _id: $ne: Meteor.userId() }, 
                sort:
                    tag_count: 1
                    points: -1
                limit: 4
    
        tag_class: -> if @valueOf() in selected_tags.array() then 'primary' else ''
    
    
