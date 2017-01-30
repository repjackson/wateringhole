@Tags = new Meteor.Collection 'tags'


FlowRouter.route '/', action: ->
    BlazeLayout.render 'layout', 
        main: 'home'


FlowRouter.route '/features', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'features'

FlowRouter.route '/faq', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'faq'

FlowRouter.route '/pricing', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'pricing'

FlowRouter.route '/about', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'about'




FlowRouter.route '/profile/edit/:user_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_profile'

FlowRouter.route '/profile/view/:user_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'view_profile'


