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
                        if person.EMAIL
                            console.log person.EMAIL
                            found = Accounts.findUserByEmail(person.EMAIL)
                            # found = Meteor.users.findOne({emails[0]["address"]: email})
                            if found 
                                console.log 'found'
                            else
                                Accounts.createUser 
                                    email: person.EMAIL
                                    profile: person
                        #         #                             profile:
                        #         # phone: person.phone
                        #         # company: person.company
                        #         # phone: person.phone
                        #         # position: person["JOB TITLE"]
                        #         # website: person.website
                        #         # bio: person["WHAT WORKING ON / INTEREST IN SOCIAL CHANGE"]
                        #         # address: 
                        #         #     address_1: person["ADDRESS 1"]
                        #         #     address_2: person["ADDRESS 2"]
                        #         #     city: person["CITY"]
                        #         #     state: person["STATE"]
                        #         #     zip: person["ZIP"]
                        #         # company: person.company
                                