FlowRouter.route '/view_profile/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'doc_profile_view'




if Meteor.isClient
    Template.doc_profile_view.onCreated ->
        self = @
        self.autorun ->
            self.subscribe 'doc', FlowRouter.getParam('doc_id')
    
    
    
    Template.doc_profile_view.helpers
        profile: ->
            Docs.findOne FlowRouter.getParam('doc_id')
    
    
    
    Template.doc_profile_view.events
        'click .edit': ->
            doc_id = FlowRouter.getParam('doc_id')
            FlowRouter.go "/edit_profile/#{doc_id}"
