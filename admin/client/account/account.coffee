Template.account.onCreated ->
    # self = @
    # self.autorun ->
    #     self.subscribe 'comp', selected_account_tags.array()


Template.account.helpers
    me: ->
        Meteor.user()


    components: -> Components
        

Template.account.events
    'click #add_page': ->
        id = Docs.insert 
            type: 'page'
            tags: ['page']
        FlowRouter.go "/page/edit/#{id}"
    
