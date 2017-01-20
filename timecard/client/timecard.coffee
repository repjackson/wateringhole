Template.timecard.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'timecard', FlowRouter.getParam('user_id')




Template.timecard.helpers
    logs: ->
        Docs.find {},
            sort: timestamp: -1