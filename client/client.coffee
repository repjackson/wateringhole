@selected_tags = new ReactiveArray []

Template.cloud.onCreated ->
    @autorun -> Meteor.subscribe 'tags', selected_tags.array()
    @autorun -> Meteor.subscribe 'me'
    # @autorun -> Meteor.subscribe 'usernames'


Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'
    dropdownClasses: 'simple'
    
$.cloudinary.config
    cloud_name:"facet"



Template.people.onCreated ->
    @autorun -> Meteor.subscribe('people', selected_tags.array())


Template.people.helpers
    people: -> 
        Meteor.users.find { _id: $ne: Meteor.userId() }, 
            sort:
                tag_count: 1
                points: -1
            limit: 10

    tag_class: -> if @valueOf() in selected_tags.array() then 'primary' else ''


