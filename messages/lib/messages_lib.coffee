@Messages = new Meteor.Collection 'messages'

Messages.helpers
    from: -> Meteor.users.findOne @from_id
    to: -> Meteor.users.findOne @to_id
    when: -> moment(@timestamp).fromNow()


FlowRouter.route '/messages', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'message_page'

Meteor.methods
    send_message: (text, to_id) ->
        console.log text
        Messages.insert
            timestamp: Date.now()
            from_id: Meteor.userId()
            text: text
            to_id: to_id

