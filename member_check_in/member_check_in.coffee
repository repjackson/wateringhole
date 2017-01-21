FlowRouter.route '/member-check-in', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'member_check_in'



if Meteor.isClient
    Session.setDefault 'selected_member_id', null
    
    
    Template.member_check_in.onCreated ->
        self = @
        self.autorun ->
            self.subscribe 'user_names'
            self.subscribe 'profile', Session.get 'selected_member_id'
    
    
    
    Template.member_check_in.helpers
        member_name_settings: -> {
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
    
        submit_button_class: ->
            if Session.get 'selected_member_id' then '' else 'disabled'
    
        selection: -> Session.get 'selected_member_id'
        
        selection_image_id: ->
            if Session.get 'selected_member_id'
                Meteor.users.findOne(Session.get('selected_member_id')).image_id
    
    
    Template.member_check_in.events
        'click #check_in_member': ->
            console.log $('#member_name').val()
            
            
        'autocompleteselect #member_name': (event, template, doc) ->
            # console.log 'selected ', doc
            Session.set 'selected_member_id', doc._id
