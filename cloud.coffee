if Meteor.isClient
    
    Template.cloud.onCreated ->
        @autorun -> Meteor.subscribe 'tags', selected_tags.array()
        @autorun -> Meteor.subscribe 'me'
        # @autorun -> Meteor.subscribe 'usernames'
    
    

    
    
    
    Template.cloud.helpers
        all_tags: ->
            user_count = Meteor.users.find( _id: $ne: Meteor.userId() ).count()
            if 0 < user_count < 3 then Tags.find({ count: $lt: user_count }, {limit:10}) else Tags.find({}, limit:10)
    
        cloud_tag_class: ->
            button_class = switch
                when @index <= 5 then 'large'
                when @index <= 12 then ''
                when @index <= 20 then 'small'
            return button_class
    
        selected_tags: -> selected_tags.list()
    
        settings: -> {
            position: 'bottom'
            limit: 10
            rules: [
                {
                    collection: Tags
                    field: 'name'
                    matchAll: true
                    template: Template.tag_result
                }
                ]
        }
    
    
    
    Template.cloud.events
        'click .select_tag': -> selected_tags.push @name
        'click .unselect_tag': -> selected_tags.remove @valueOf()
        'click #clear_tags': -> selected_tags.clear()
    
    
        'keyup #search': (e,t)->
            e.preventDefault()
            val = $('#search').val().toLowerCase().trim()
            switch e.which
                when 13 #enter
                    switch val
                        when 'clear'
                            selected_tags.clear()
                            $('#search').val ''
                        else
                            unless val.length is 0
                                selected_tags.push val.toString()
                                $('#search').val ''
                when 8
                    if val.length is 0
                        selected_tags.pop()
                        
        'autocompleteselect #search': (event, template, doc) ->
            # console.log 'selected ', doc
            selected_tags.push doc.name
            $('#search').val ''
