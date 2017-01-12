Messages.allow
    insert: (userId, doc) -> doc.author_id is userId
    update: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
    remove: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')



Meteor.publish 'sent_messages', ->
    Messages.find
        author_id: @userId


Meteor.publish 'received_messages', ->
    Messages.find
        recipient_id: @userId

