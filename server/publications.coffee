
Meteor.publish 'people', -> Meteor.users.find {}

Meteor.publish 'person', (id)-> Meteor.users.find id

Meteor.publish 'me', ->
    Meteor.users.find @userId,
        fields:
            cloud: 1




Meteor.publish 'tags', (selected_tags)->
    self = @

    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    if not @userId? then match.personal = false

    cloud = Meteor.users.aggregate [
        { $match: match }
        { $project: tags: 1 }
        { $unwind: '$tags' }
        { $group: _id: '$tags', count: $sum: 1 }
        { $match: _id: $nin: selected_tags }
        { $sort: count: -1, _id: 1 }
        { $limit: 50 }
        { $project: _id: 0, name: '$_id', count: 1 }
        ]

    cloud.forEach (tag) ->
        self.added 'tags', Random.id(),
            name: tag.name
            count: tag.count

    self.ready()
