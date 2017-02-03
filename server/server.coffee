Docs.allow
    insert: (userId, doc) -> doc.author_id is userId
    update: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
    remove: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')


Meteor.users.allow
    update: (userId, doc, fields, modifier) ->
        true
        # # console.log 'user ' + userId + 'wants to modify doc' + doc._id
        # if userId and doc._id == userId
        #     # console.log 'user allowed to modify own account'
        #     true

Cloudinary.config
    cloud_name: 'facet'
    api_key: Meteor.settings.cloudinary_key
    api_secret: Meteor.settings.cloudinary_secret





Meteor.publish 'people', (selected_tags)->
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    # match.tags = $all: selected_tags
    match._id = $ne: @userId
    # match.checked_in = true
    
    Meteor.users.find match,
        fields:
            tags: 1
            username: 1
            image_id: 1
            name: 1
            emails: 1
            checked_in: 1
            profile: 1
        ,
        limit: 4



Meteor.publish 'profile', (id)->
    Meteor.users.find id,
        fields:
            tags: 1
            username: 1
            image_id: 1
            name: 1
            profile: 1
            emails: 1
            checked_in: 1
            monthly_day_usage: 1
            checkins_this_month: 1
            member_status: 1
            day_allotment: 1
            member_type: 1

Meteor.publish 'user_names', ->
    Meteor.users.find {},
        fields: 
            name: 1
            member_status: 1

AccountsMeld.configure
    askBeforeMeld: false
    # meldDBCallback: meldDBCallback
    # serviceAddedCallback: serviceAddedCallback

