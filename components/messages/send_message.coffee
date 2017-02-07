FlowRouter.route '/message/edit/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'send_message'

