@Messages = new Meteor.Collection 'messages'

Messages.helpers
    author: -> Meteor.users.findOne @author_id
    recipient: -> Meteor.users.findOne @recipient_id
    when: -> moment(@timestamp).fromNow()


FlowRouter.route '/messages', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'message_page'

Meteor.methods
    send_message: (text, conversation_id) ->
        Messages.insert
            timestamp: Date.now()
            author_id: Meteor.userId()
            text: text
            conversation_id: conversation_id

