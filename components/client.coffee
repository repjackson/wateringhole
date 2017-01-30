if Meteor.isClient
    @selected_tags = new ReactiveArray []

    Accounts.ui.config
        passwordSignupFields: 'USERNAME_ONLY'
        dropdownClasses: 'simple'
        
    $.cloudinary.config
        cloud_name:"facet"
    
    
    
