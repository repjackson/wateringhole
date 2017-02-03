@Herd_tags= new Meteor.Collection 'herd_tags'




if Meteor.isClient
    @selected_herd_tags = new ReactiveArray []
    
    Template.herd_cloud.onCreated ->
        @autorun -> Meteor.subscribe 'herd_tags', selected_herd_tags.array()
    
    
    Template.herd_cloud.helpers
        herd_tags: ->
            herd_count = Herds.find().count()
            if 0 < herd_count < 3 then Herd_tags.find { count: $lt: herd_count } else Herd_tags.find()

            # herd_tags.find()

        cloud_tag_class: ->
            button_class = switch
                when @index <= 5 then 'large'
                when @index <= 12 then ''
                when @index <= 20 then 'small'
            return button_class
    
        selected_herd_tags: -> selected_herd_tags.list()
    

    
    
    Template.herd_cloud.events
        'click .select_tag': -> selected_herd_tags.push @name
        'click .unselect_tag': -> selected_herd_tags.remove @valueOf()
        'click #clear_tags': -> selected_herd_tags.clear()
    


if Meteor.isServer
    Meteor.publish 'herd_tags', (selected_herd_tags)->
        self = @
        match = {}
        if selected_herd_tags.length > 0 then match.tags = $all: selected_herd_tags

    
        cloud = Herds.aggregate [
            { $match: match }
            { $project: tags: 1 }
            { $unwind: "$tags" }
            { $group: _id: '$tags', count: $sum: 1 }
            { $match: _id: $nin: selected_herd_tags }
            { $sort: count: -1, _id: 1 }
            { $limit: 20 }
            { $project: _id: 0, name: '$_id', count: 1 }
            ]
        # console.log 'cloud, ', cloud
        cloud.forEach (tag, i) ->
            self.added 'herd_tags', Random.id(),
                name: tag.name
                count: tag.count
                index: i
    
        self.ready()
        
    
    
