@Importers = new Meteor.Collection 'importers'

Meteor.methods
    toggleFieldTag: (id, fieldName, value)->
        Importers.update {
            _id: id
            fieldsObject: $elemMatch:
                name: fieldName
            }, $set: 'fieldsObject.$.tag': value




Slingshot.fileRestrictions 'myFileUploads',
    allowedFileTypes: null
    maxSize: 10 * 1024 * 1024


FlowRouter.route '/admin/importers', action: (params) -> BlazeLayout.render 'layout', main: 'importer_list'

FlowRouter.route '/admin/importers/:importer_id', action: (params) -> BlazeLayout.render 'layout', main: 'importer_view'

FlowRouter.route '/bulk', action: (params) -> BlazeLayout.render 'layout', main: 'bulk'

FlowRouter.route '/mine',
    action: (params) ->
        Session.set('view', 'mine')
        BlazeLayout.render 'layout', main: 'home'
