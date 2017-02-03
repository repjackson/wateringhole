
FlowRouter.route '/view_herd/:herd_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'view_herd'




if Meteor.isClient
    Template.view_herd.onCreated ->
        self = @
        self.autorun ->
            self.subscribe 'herd', FlowRouter.getParam('herd_id')
    
    
    
    Template.view_herd.helpers
        herd: ->
            Herds.findOne FlowRouter.getParam('herd_id')
    
        # ecosystem_tags: ->
        #     _.without(@tags, 'ecosystem') 
    
        is_member: ->
            Meteor.userId() in @members
            
        member_list: ->
            list = []
            for member_id in @members
                person = Meteor.users.findOne member_id
                list.push person
            return list
                
        is_inside_herd: ->
            @herd_tag is Meteor.user().profile.current_herd
            
    
    Template.view_herd.events
        'click .edit': ->
            herd_id = FlowRouter.getParam('herd_id')
            FlowRouter.go "/edit_herd/#{herd_id}"


        'click #join_herd': ->
            Herds.update FlowRouter.getParam('herd_id'),
                $addToSet: members: Meteor.userId()
        
        'click #leave_herd': ->
            Herds.update FlowRouter.getParam('herd_id'),
                $pull: members: Meteor.userId()
            
        'click #go_inside_herd': ->
            Meteor.call 'go_inside_herd', @_id

        'click #go_outside_herd': ->
            Meteor.call 'go_outside_herd'



if Meteor.isServer
    Meteor.publish 'herd', (id)->
        Herds.find id
    
    Meteor.methods
        go_inside_herd: (id)->
            herd = Herds.findOne id
            Meteor.users.update Meteor.userId(),
                $set: "profile.current_herd": herd.herd_tag
        
        go_outside_herd: ->
            Meteor.users.update Meteor.userId(),
                $set: "profile.current_herd": null
            