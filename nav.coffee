if Meteor.isClient
    Template.nav.events
        'click #logout': -> AccountsTemplates.logout()
    
        
    Template.nav.helpers
