Template.member_demo.events
    'click #add_demo_member': ->
        id = Docs.insert type: 'demo_member'
        FlowRouter.go "/edit/#{id}"

