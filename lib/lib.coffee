@Tags = new Meteor.Collection 'tags'


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

