
Template.edit_profile.onCreated ->
    @autorun -> Meteor.subscribe 'user_profile'



Template.edit_profile.helpers
    ten_tags: -> @tags?.length is 10
    # person: -> Meteor.users.findOne FlowRouter.getParam('user_id')

    # matchedUsersList:->
    #     users = Meteor.users.find({_id: $ne: Meteor.userId()}).fetch()
    #     userMatches = []
    #     for user in users
    #         tagIntersection = _.intersection(user.tags, Meteor.user().tags)
    #         userMatches.push
    #             matchedUser: user.username
    #             tagIntersection: tagIntersection
    #             length: tagIntersection.length
    #     sortedList = _.sortBy(userMatches, 'length').reverse()
    #     return sortedList



Template.edit_profile.events
    'click #save_profile': ->
        FlowRouter.go "/view/#{Meteor.userId()}"

    'blur #name': ->
        name = $('#name').val()
        Meteor.users.update Meteor.userId(),
            $set: "profile.name": name
            
    'blur #link': ->
        link = $('#link').val()
        Meteor.users.update Meteor.userId(),
            $set: "profile.link": link
            
    'blur #location': ->
        location = $('#location').val()
        Meteor.users.update Meteor.userId(),
            $set: "profile.location": location
            
            
            
            
            
    'blur #personal_bio': ->
        personal_bio = $('#personal_bio').val()
        Meteor.users.update Meteor.userId(),
            $set: "profile.personal_bio": personal_bio
            
    'blur #pro_bio': ->
        pro_bio = $('#pro_bio').val()
        Meteor.users.update Meteor.userId(),
            $set: "profile.pro_bio": pro_bio
            

    'keydown #add_tag': (e,t)->
        if e.which is 13
            tag = $('#add_tag').val().toLowerCase().trim()
            if tag.length > 0
                Meteor.users.update Meteor.userId(),
                    $addToSet: tags: tag
                $('#add_tag').val('')

    'click .person_tag': (e,t)->
        tag = @valueOf()
        Meteor.users.update Meteor.userId(),
            $pull: tags: tag
        $('#add_tag').val(tag)



    "change input[type='file']": (e) ->
        files = e.currentTarget.files
        Cloudinary.upload files[0],
            # folder:"secret" # optional parameters described in http://cloudinary.com/documentation/upload_images#remote_upload
            # type:"private" # optional: makes the image accessible only via a signed url. The signed url is available publicly for 1 hour.
            (err,res) -> #optional callback, you can catch with the Cloudinary collection as well
                # console.log "Upload Error: #{err}"
                # console.dir res
                if err
                    console.error 'Error uploading', err
                else
                    Meteor.users.update Meteor.userId(),
                        $set: "profile.image_id": res.public_id
                return

    'click #pick_google_image': ->
        picture = Meteor.user().profile.google_image
        Meteor.call 'download_image', picture, (err, res)->
            if err
                console.error err
            else
                console.log typeof res
                Cloudinary.upload res,
                    # folder:"secret" # optional parameters described in http://cloudinary.com/documentation/upload_images#remote_upload
                    # type:"private" # optional: makes the image accessible only via a signed url. The signed url is available publicly for 1 hour.
                    (err,res) -> #optional callback, you can catch with the Cloudinary collection as well
                        # console.log "Upload Error: #{err}"
                        # console.dir res
                        if err
                            console.error 'Error uploading', err
                        else
                            console.log 'i think this worked'
                            Meteor.users.update Meteor.userId(), 
                                $set: "profile.image_id": res.public_id
                        return


    'click #remove_photo': ->
        Meteor.users.update Meteor.userId(),
            $unset: "profile.image_id": 1
            