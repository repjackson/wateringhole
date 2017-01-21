FlowRouter.route '/guest-check-in', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'guest_check_in'



if Meteor.isClient
    Template.guest_check_in.onCreated ->
        self = @
        self.autorun ->
            self.subscribe 'user_names'
    
    
    
    
    Template.guest_check_in.helpers
        name_settings: -> {
            position: 'bottom'
            limit: 10
            rules: [
                {
                    collection: Meteor.users
                    field: 'name'
                    matchAll: true
                    template: Template.tag_result
                }
                ]
        }
        
        
        
    Template.guest_check_in.events
        # 'click .delete_entry': ->
        #     if confirm 'Delete Entry?'
        #         Docs.remove @_id
        
        
        
if Meteor.isServer
    Meteor.publish 'user_names', ->
        Meteor.users.find {},
            field: 
                name: 1