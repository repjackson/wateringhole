Template.message_user.events
    'keyup #new_message': (e,t)->
        e.preventDefault()
        if e.which is 13
            val = $('#new_message').val().toLowerCase().trim()
            Meteor.call 'send_message', val, t.data._id, ->
                $('#new_message').val('')

            