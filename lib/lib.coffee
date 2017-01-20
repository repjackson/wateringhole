@Tags = new Meteor.Collection 'tags'
@Docs = new Meteor.Collection 'docs'


FlowRouter.route '/',
    name: 'home'
    action: ->
        BlazeLayout.render 'layout', 
            cloud: 'cloud'
            main: 'people'


FlowRouter.route '/profile/edit/:user_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_profile'

FlowRouter.route '/profile/view/:user_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'view_profile'


