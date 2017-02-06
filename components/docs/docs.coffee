@Docs = new Meteor.Collection 'docs'

Docs.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    doc.points = 0
    doc.down_voters = []
    doc.tags.push Meteor.user().profile.current_herd
    doc.up_voters = []
    return


# Docs.after.insert (userId, doc)->
#     console.log doc.tags
#     return

Docs.after.update ((userId, doc, fieldNames, modifier, options) ->
    doc.tag_count = doc.tags?.length
    # Meteor.call 'generate_authored_cloud'
), fetchPrevious: true


Docs.helpers
    author: -> Meteor.users.findOne @author_id
    when: -> moment(@timestamp).fromNow()

FlowRouter.route '/docs', action: (params) ->
    BlazeLayout.render 'layout',
        # cloud: 'cloud'
        main: 'docs'

Meteor.methods
    add: (tags=[])->
        id = Docs.insert
            tags: tags
        # Meteor.call 'generate_person_cloud', Meteor.userId()
        return id


if Meteor.isClient
    Template.docs.onCreated -> 
        @autorun -> Meteor.subscribe('docs', selected_tags.array())

    Template.docs.helpers
        docs: -> 
            Docs.find { }, 
                sort:
                    tag_count: 1
                limit: 1
    
        tag_class: -> if @valueOf() in selected_tags.array() then 'primary' else 'basic'

        selected_tags: -> selected_tags.list()

    
    Template.view.helpers
        is_author: -> Meteor.userId() and @author_id is Meteor.userId()
    
        tag_class: -> if @valueOf() in selected_tags.array() then 'primary' else 'basic'
    
        when: -> moment(@timestamp).fromNow()

    Template.view.events
        'click .tag': -> if @valueOf() in selected_tags.array() then selected_tags.remove(@valueOf()) else selected_tags.push(@valueOf())
    
        'click .edit': -> FlowRouter.go("/edit/#{@_id}")

    Template.docs.events
        'click #add': ->
            Meteor.call 'add', (err,id)->
                FlowRouter.go "/edit/#{id}"
    
        'keyup #quick_add': (e,t)->
            e.preventDefault
            tag = $('#quick_add').val().toLowerCase()
            if e.which is 13
                if tag.length > 0
                    split_tags = tag.match(/\S+/g)
                    $('#quick_add').val('')
                    Meteor.call 'add', split_tags
                    selected_tags.clear()
                    for tag in split_tags
                        selected_tags.push tag
    


if Meteor.isServer
    Docs.allow
        insert: (userId, doc) -> doc.author_id is userId
        update: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
        remove: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
    
    
    
    
    Meteor.publish 'docs', (selected_tags, filter)->
    
        user = Meteor.users.findOne @userId
        current_herd = user.profile.current_herd
    
        self = @
        match = {}
        selected_tags.push current_herd
        match.tags = $all: selected_tags
        # if selected_tags.length > 0 then match.tags = $all: selected_tags
        if filter then match.type = filter

        

        Docs.find match,
            limit: 5
            
    
    Meteor.publish 'doc', (id)->
        Docs.find id
    
    
    
    Meteor.publish 'doc_tags', (selected_tags)->
        
        user = Meteor.users.findOne @userId
        current_herd = user.profile.current_herd
        
        self = @
        match = {}
        
        selected_tags.push current_herd
        match.tags = $all: selected_tags

        
        cloud = Docs.aggregate [
            { $match: match }
            { $project: tags: 1 }
            { $unwind: "$tags" }
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
        
