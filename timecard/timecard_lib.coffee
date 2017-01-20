Meteor.methods
    'check_in_user': (user_id) ->
        user = Meteor.users.findOne user_id
        Meteor.users.update user_id,
            $set: checked_in: true
        Docs.insert 
            author_id: user_id
            type: 'timecard'
            timestamp: Date.now()
            tags: ['timecard', user.name, 'in', Date.now()]


    'check_out_user': (user_id) ->
        user = Meteor.users.findOne user_id
        Meteor.users.update user_id,
            $set: checked_in: false
        Docs.insert 
            author_id: user_id
            type: 'timecard'
            timestamp: Date.now()
            tags: ['timecard', user.name, 'out', Date.now()]
