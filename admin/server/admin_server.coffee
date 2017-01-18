


Meteor.publish 'hub_users', ->
    match = {}

    Meteor.users.find match,
        fields:
            tags: 1
            name: 1
            roles: 1