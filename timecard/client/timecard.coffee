Template.timecard.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'timecard', FlowRouter.getParam('user_id')




Template.timecard.helpers
    logs: ->
        Docs.find {},
            sort: timestamp: -1
        
    date_format: ->
        moment(@timestamp).format('dddd, MMMM Do YYYY, h:mm a')
        
    is_in: -> 'in' in @tags

    this_month: ->
        now = Date.now()
        moment(now).format('MMMM')


Template.timecard.events
    'click .delete_entry': ->
        if confirm 'Delete Entry?'
            Docs.remove @_id