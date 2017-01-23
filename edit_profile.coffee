if Meteor.isClient
    Template.edit_profile.onCreated ->
        @autorun -> Meteor.subscribe 'profile', FlowRouter.getParam('user_id') 
    
    # Template.edit_profile.onRendered ->
    #     console.log Meteor.users.findOne(FlowRouter.getParam('user_id'))
    
    Template.edit_profile.helpers
        ten_tags: -> @tags?.length is 10
    
        user: -> Meteor.users.findOne FlowRouter.getParam('user_id')
    
    Template.edit_profile.events
        'blur #name': ->
            old_name_tags = @name_tags
            # console.log old_name_tags
            name = $('#name').val()
            split_name = name.match(/\S+/g)
            
            Meteor.users.update FlowRouter.getParam('user_id'),
                $pullAll: tags: old_name_tags
                    
            Meteor.users.update FlowRouter.getParam('user_id'),
                $set: 
                    name: name
                    name_tags: split_name
                $addToSet: tags: $each: split_name
                
            
        'keydown #input_image_id': (e,t)->
            if e.which is 13
                user_id = FlowRouter.getParam('user_id')
                image_id = $('#input_image_id').val().toLowerCase().trim()
                if image_id.length > 0
                    Meteor.users.update user_id,
                        $set: image_id: image_id
                    $('#input_image_id').val('')
                
                
        'keydown #add_tag': (e,t)->
            if e.which is 13
                tag = $('#add_tag').val().toLowerCase().trim()
                if tag.length > 0
                    Meteor.users.update FlowRouter.getParam('user_id'),
                        $addToSet: tags: tag
                    $('#add_tag').val('')
    
        'click .person_tag': (e,t)->
            tag = @valueOf()
            Meteor.users.update FlowRouter.getParam('user_id'),
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
                        Meteor.users.update FlowRouter.getParam('user_id'),
                            $set: image_id: res.public_id
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
                                Meteor.users.update FlowRouter.getParam('user_id'), 
                                    $set: "profile.image_id": res.public_id
                            return
    
    
        'click #remove_photo': ->
            Meteor.users.update FlowRouter.getParam('user_id'),
                $unset: image_id: 1
                