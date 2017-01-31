if Meteor.isClient

    Template.member_demo_cards.onCreated ->
        @autorun -> Meteor.subscribe('demo_members', selected_member_demo_tags.array())
    
    
    Template.member_demo_cards.helpers
        demo_members: -> 
            Docs.find
                type: 'demo_member'


    Template.member_demo_card.helpers
        demo_member_tag_class: -> if @valueOf() in selected_member_demo_tags.array() then 'primary' else 'basic'
    
    
if Meteor.isServer
    Meteor.publish 'demo_members', (selected_member_demo_tags)->
        match = {}
        match.tags = $all: selected_member_demo_tags
        match.type = 'demo_member'
        
        Docs.find match, limit: 4
