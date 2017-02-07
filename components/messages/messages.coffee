@Messages = new Meteor.Collection 'messages'

Messages.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    return



Messages.helpers
    author: -> Meteor.users.findOne @author_id
    when: -> moment(@timestamp).fromNow()

FlowRouter.route '/messages', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'messages'

if Meteor.isClient
    Template.messages.onCreated -> 
        @autorun -> Meteor.subscribe('messages')

    Template.messages.helpers
        messages: -> 
            Messages.find { }

    
    Template.view.helpers
        is_author: -> Meteor.userId() and @author_id is Meteor.userId()
    
        when: -> moment(@timestamp).fromNow()

    Template.view.events
        # 'click .edit': -> FlowRouter.go("/edit/#{@_id}")

    Template.messages.events


if Meteor.isServer
    Messages.allow
        insert: (userId, doc) -> doc.author_id is userId
        update: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
        remove: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
    
    
    
    
    Meteor.publish 'messages', (selected_tags)->
    
        user = Meteor.users.findOne @userId

        self = @
        match = {}


        Messages.find match,
            limit: 5
            
    
    Meteor.publish 'message', (id)->
        Messages.find id


    Meteor.methods
        send_message: (recipient_id, text)->
            Messages.insert
                recipient_id: recipient_id
                text: text