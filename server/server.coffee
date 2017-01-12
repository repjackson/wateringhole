Meteor.publish 'me', -> 
    Meteor.users.find @userId
        # fields: 
        #     points: 1

Meteor.publish 'usernames', () -> 
    Meteor.users.find()


Meteor.publish 'tags', (selected_tags)->
    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags

    cloud = Meteor.users.aggregate [
        { $match: match }
        { $project: tags: 1 }
        { $unwind: "$profile.tags" }
        { $group: _id: '$tags', count: $sum: 1 }
        { $match: _id: $nin: selected_tags }
        { $sort: count: -1, _id: 1 }
        { $limit: 20 }
        { $project: _id: 0, name: '$_id', count: 1 }
        ]
    # console.log 'cloud, ', cloud
    cloud.forEach (tag, i) ->
        self.added 'tags', Random.id(),
            name: tag.name
            count: tag.count
            index: i

    self.ready()
    


Meteor.publish 'people', (selected_tags)->
    match = {}
    if selected_tags.length > 0 then match.profile.tags = $all: selected_tags
    # match.tags = $all: selected_tags

    Meteor.users.find match


Meteor.methods
    generate_person_cloud: (uid)->

        cloud = Docs.aggregate [
            { $match: author_id: Meteor.userId() }
            { $project: tags: 1 }
            { $unwind: '$tags' }
            { $group: _id: '$tags', count: $sum: 1 }
            { $sort: count: -1, _id: 1 }
            { $limit: 20 }
            { $project: _id: 0, name: '$_id', count: 1 }
            ]
            
            
        list = (tag.name for tag in cloud)
        Meteor.users.update Meteor.userId(),
            $set:
                cloud: cloud
                list: list


# Meteor.publish 'my_profile', ->
#     Meteor.users.find @userId,
#         fields:
#             tags: 1
#             profile: 1
#             username: 1
#             published: 1
#             image_id: 1


# Meteor.publish 'user_profile', (id)->
#     Meteor.users.find id,
#         fields:
#             tags: 1
#             profile: 1
#             username: 1
#             published: 1
#             image_id: 1


Meteor.publish 'user_profile', ->
    Meteor.users.find @userId


    
Meteor.publish 'view_profile', (user_id)->
    Meteor.users.find user_id

        
Meteor.methods