Meteor.publish 'timecard', (user_id)->
    Docs.find
        author_id: user_id
        type: 'timecard'