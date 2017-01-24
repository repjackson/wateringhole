if Meteor.isClient
    Template.nav.events
        'click #logout': -> AccountsTemplates.logout()
    
        'click #parse': -> 
            Meteor.call 'parse'
        
    Template.nav.helpers



if Meteor.isServer
    Meteor.methods
        parse: ->
            file = Assets.getText('members.csv')
            Papa.parse file, 
                header: true
                complete: (results) ->
                    for person in results.data
                        split_tags = person.SKILLS.split("/")
                        console.log split_tags
                        if person.EMAIL
                            # console.log person.EMAIL
                            found = Accounts.findUserByEmail(person.EMAIL)
                            # found = Meteor.users.findOne({emails[0]["address"]: email})
                            if found 
                                console.log 'found'
                            else
                                person.image_id = 'blank_profile'
                                person.tags = split_tags
                                Accounts.createUser 
                                    email: person.EMAIL
                                    profile: person
                                    
