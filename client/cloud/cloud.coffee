Template.cloud.helpers
    all_tags: ->
        Tags.find()

    cloud_tag_class: ->
        buttonClass = switch
            when @index <= 5 then ''
            when @index <= 12 then 'small'
            when @index <= 20 then 'tiny'
        return buttonClass

    selected_tags: -> selected_tags.list()


Template.cloud.events
    'click .select_tag': -> selected_tags.push @name
    'click .unselect_tag': -> selected_tags.remove @valueOf()
    'click #clear_tags': -> selected_tags.clear()
