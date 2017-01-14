@Tags = new Meteor.Collection 'tags'
@Docs = new Meteor.Collection 'docs'


FlowRouter.route '/',
    name: 'home'
    action: ->
        BlazeLayout.render 'layout', 
            cloud: 'cloud'
            main: 'people'


FlowRouter.route '/profile/edit/', action: (params) ->
    BlazeLayout.render 'layout',
        # sub_nav: 'account_nav'
        main: 'edit_profile'

FlowRouter.route '/view/:user_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'view_profile'

