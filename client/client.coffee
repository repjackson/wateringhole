@selected_tags = new ReactiveArray []

Template.cloud.onCreated ->
    @autorun -> Meteor.subscribe 'tags', selected_tags.array()
    @autorun -> Meteor.subscribe 'me'
    # @autorun -> Meteor.subscribe 'usernames'


Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'
    dropdownClasses: 'simple'
    

Template.cloud.helpers
    all_tags: ->
        # docCount = Docs.find().count()
        # if 0 < docCount < 3 then Tags.find({ count: $lt: docCount }, {limit:20}) else Tags.find({}, limit:20)
        Tags.find()

    cloud_tag_class: ->
        buttonClass = switch
            when @index <= 5 then ''
            when @index <= 12 then 'small'
            when @index <= 20 then 'tiny'
        return buttonClass

    selected_tags: -> selected_tags.list()



Template.people.onCreated ->
    @autorun -> Meteor.subscribe('people', selected_tags.array())


Template.people.helpers
    people: -> 
        Meteor.users.find { }, 
            sort:
                tag_count: 1
                points: -1
            limit: 10

    tag_class: -> if @valueOf() in selected_tags.array() then 'primary' else ''


Template.cloud.events
    'click .select_tag': -> selected_tags.push @name
    'click .unselect_tag': -> selected_tags.remove @valueOf()
    'click #clear_tags': -> selected_tags.clear()
