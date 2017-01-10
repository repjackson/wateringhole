@selected_tags = new ReactiveArray []

Template.cloud.onCreated ->
    @autorun -> Meteor.subscribe 'tags', selected_tags.array()
    @autorun -> Meteor.subscribe 'me'
    @autorun -> Meteor.subscribe 'usernames'



Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'

Accounts.ui.config
    dropdownClasses: 'simple'
    

Template.cloud.helpers
    all_tags: ->
        # docCount = Docs.find().count()
        # if 0 < docCount < 3 then Tags.find({ count: $lt: docCount }, {limit:20}) else Tags.find({}, limit:20)
        Tags.find()

    me: -> Meteor.user()

    cloud_tag_class: ->
        buttonClass = switch
            when @index <= 5 then ''
            when @index <= 12 then 'small'
            when @index <= 20 then 'tiny'
        return buttonClass

    selected_tags: -> selected_tags.list()



Template.docs.onCreated ->
    @autorun -> Meteor.subscribe('docs', selected_tags.array())


Template.docs.helpers
    docs: -> 
        Docs.find { }, 
            sort:
                tag_count: 1
                points: -1
            limit: 10

    tag_class: -> if @valueOf() in selected_tags.array() then 'primary' else ''

    # is_editing: -> Session.equals 'editing', @_id 

Template.cloud.events
    'click .select_tag': -> selected_tags.push @name
    'click .unselect_tag': -> selected_tags.remove @valueOf()
    'click #clear_tags': -> selected_tags.clear()




Template.edit.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'doc', FlowRouter.getParam('doc_id')
        # self.subscribe 'tags', selected_type_of_event_tags.array(),"event"

Template.view.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'person', Template.currentData().author_id



Template.edit.helpers
    doc: -> Docs.findOne FlowRouter.getParam('doc_id')
    

        
Template.edit.events
    'click #delete_doc': ->
        Meteor.call 'delete', FlowRouter.getParam('doc_id'), (error, result) ->
            if error
                console.error error.reason
            else
                Session.set 'editing', null

    'keydown #add_tag': (e,t)->
        switch e.which
            when 13
                doc_id = FlowRouter.getParam('doc_id')
                tag = $('#add_tag').val().toLowerCase().trim()
                if tag.length > 0
                    Docs.update doc_id,
                        $addToSet: tags: tag
                    $('#add_tag').val('')
                else
                    Docs.update FlowRouter.getParam('doc_id'),
                        $set:
                            tag_count: @tags.length
                    Meteor.call 'generate_person_cloud', Meteor.userId()
                    Session.set 'editing', null

                    
    'click .doc_tag': (e,t)->
        doc = Docs.findOne FlowRouter.getParam('doc_id')
        tag = @valueOf()
        Docs.update FlowRouter.getParam('doc_id'),
            $pull: tags: tag
        $('#add_tag').val(tag)


    'click #save': ->
        Docs.update FlowRouter.getParam('doc_id'),
            $set:
                tag_count: @tags.length
        Meteor.call 'generate_person_cloud', Meteor.userId()
        Session.set 'editing', null



Template.view.helpers
    is_author: -> Meteor.userId() and @author_id is Meteor.userId()
    is_mine: -> 
        last_doc = Docs.findOne()
        console.log last_doc
        Meteor.userId() and last_doc.author_id is Meteor.userId()

    tag_class: -> if @valueOf() in selected_tags.array() then 'blue' else ''

    # when: -> moment(@timestamp).fromNow()
    
    vote_up_button_class: ->
        if not Meteor.userId() then 'disabled basic'
        # else if Meteor.user().points < 1 then 'disabled basic'
        else if Meteor.userId() in @up_voters then 'green'
        else 'basic'

    vote_down_button_class: ->
        if not Meteor.userId() then 'disabled basic'
        # else if Meteor.user().points < 1 then 'disabled basic'
        else if Meteor.userId() in @down_voters then 'red'
        else 'basic'


Template.view.events
    'click .ftag': -> if @valueOf() in selected_tags.array() then selected_tags.remove(@valueOf()) else selected_tags.push(@valueOf())

    'click .edit': -> FlowRouter.go("/edit/#{@_id}")

    'click .vote_up': -> Meteor.call 'vote_up', @_id

    'click .vote_down': -> Meteor.call 'vote_down', @_id
