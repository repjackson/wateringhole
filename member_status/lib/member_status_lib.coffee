Meteor.methods
    'check_in_user': (user_id) ->
        user = Meteor.users.findOne user_id
        Meteor.users.update user_id,
            $set: checked_in: true
        Docs.insert 
            author_id: user_id
            type: 'timecard'
            timestamp: new Date()
            tags: ['timecard', user.name, 'in', Date.now()]
        Meteor.call 'calculate_user_totals', user_id


    'check_out_user': (user_id) ->
        user = Meteor.users.findOne user_id
        Meteor.users.update user_id,
            $set: checked_in: false
        Docs.insert 
            author_id: user_id
            type: 'timecard'
            timestamp: new Date()
            tags: ['timecard', user.name, 'out', Date.now()]
        Meteor.call 'calculate_user_totals', user_id