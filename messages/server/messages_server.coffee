Messages.allow
    insert: (userId, doc) -> doc.from_id is userId
    update: (userId, doc) -> doc.from_id is userId or Roles.userIsInRole(userId, 'admin')
    remove: (userId, doc) -> doc.from_id is userId or Roles.userIsInRole(userId, 'admin')



Meteor.publish 'sent_messages', ->
    Messages.find
        from_id: @userId


Meteor.publish 'received_messages', ->
    Messages.find
        to_id: @userId

