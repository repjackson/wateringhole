FlowRouter.route '/account', action: (params) ->
    BlazeLayout.render 'layout',
        sub_nav: 'account_nav'
        main: 'edit_account'



FlowRouter.route '/account/settings', action: (params) ->
    BlazeLayout.render 'layout',
        sub_nav: 'account_nav'
        main: 'account_settings'
        
        

FlowRouter.route '/account/profile/edit/:user_id', action: (params) ->
    BlazeLayout.render 'layout',
        sub_nav: 'account_nav'
        main: 'edit_profile'

FlowRouter.route '/account/profile/view/:user_id', action: (params) ->
    BlazeLayout.render 'layout',
        sub_nav: 'account_nav'
        main: 'view_profile'


