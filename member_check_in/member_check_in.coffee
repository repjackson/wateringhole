FlowRouter.route '/member-check-in', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'member_check_in'



if Meteor.isClient
    Template.guest_check_in.onCreated ->
        # self = @
        # self.autorun ->
        #     self.subscribe 'timecard', FlowRouter.getParam('user_id')
    
    
    
    
    Template.guest_check_in.helpers
        # logs: ->
        #     Docs.find {},
        #         sort: timestamp: -1
            
        # date_format: ->
        #     moment(@timestamp).format('dddd, MMMM Do YYYY, h:mm a')
            
        # is_in: -> 'in' in @tags
    
        # this_month: ->
        #     now = Date.now()
        #     moment(now).format('MMMM')
    
        # monthly_day_comparison: -> @day_allotment - @monthly_day_usage
    
    
    Template.guest_check_in.events
        # 'click .delete_entry': ->
        #     if confirm 'Delete Entry?'
        #         Docs.remove @_id