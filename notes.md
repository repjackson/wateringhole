db.docs.find({"authorId": {$exists: true}}).forEach(function(item)
{
        item.author_id = "vyqyHFRZG4CpogTAG";
        db.docs.save(item);
})


db.docs.update({
            }, {
                $set: {
                    "tag_count": 
                }
            },
            function(err) {
                if (err) console.log(err);
            }
        );
    })


db.docs.find({}).forEach(
    function(doc) {
        var tag_count = doc.tags.length;
        doc.tag_count = tag_count;
        db.docs.save(doc);
    }
)

<!--first name-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.first_name = doc["profile"]["FIRST NAME"];
        db.users.save(doc);
    }
)


<!--add first name to tags-->
db.users.find({ "profile.first_name": {$exists:true} }).forEach(
    function(doc) {
        found_first = doc.profile.first_name;
        if(found_first){
            first = doc.profile.first_name.toLowerCase();
            doc.tags.push(first);
            db.users.save(doc);
        }
    }
)

<!--last name-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.last_name = doc["profile"]["LAST NAME"];
        db.users.save(doc);
    }
)


<!--tags-->
db.users.find({ profile: {$exists:true}, "profile.tags":{$exists:true} }).forEach(
    function(doc) {
        split_tags = doc.profile.tags[0].toLowerCase().split(",");
        doc.tags = split_tags;
        db.users.save(doc);
    }
)


<!--remove whitespace tag-->
db.users.find({ tags: {$exists:true} }).forEach(
    function(doc) {
        doc.tags = doc.tags.filter(function(str) {
            return /\S/.test(str);
        });
        db.users.save(doc);
    }
)


<!--trim tags-->
db.users.find({ tags: {$exists:true} }).forEach(
    function(doc) {
        doc.tags = doc.tags.map(function(s) { return s.trim() });
        db.users.save(doc);
    }
)

<!--member status-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.member_status = doc["profile"]["MEMB STATUS"];
        db.users.save(doc);
    }
)

<!--member status-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.member_type = doc["profile"]["MEMB TYPE"];
        db.users.save(doc);
    }
)


<!--company-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.company = doc["profile"]["COMPANY"];
        db.users.save(doc);
    }
)


<!--position-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.position = doc["profile"]["JOB TITLE"];
        db.users.save(doc);
    }
)




<!--lowercase website-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.website = doc["WEBSITE"];
        db.users.save(doc);
    }
)


<!--needs-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.needs = doc["profile"]["NEEDS"];
        db.users.save(doc);
    }
)


<!--phone-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.phone = doc["profile"]["PHONE"];
        db.users.save(doc);
    }
)





<!--lowercase website-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.website = doc["profile"]["WEBSITE"];
        db.users.save(doc);
    }
)


<!--what working on-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.pro_bio = doc["profile"]["WHAT WORKING ON / INTEREST IN SOCIAL CHANGE"];
        db.users.save(doc);
    }
)


db.users.update( { }, { $unset: { "profile.website": 1 } }, { multi: true } )







<!--image-->
db.users.find({ image_id:{$exists:true}, profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.image_id = doc.image_id;
        db.users.save(doc);
    }
)




mongo --ssl --sslAllowInvalidCertificates aws-us-east-1-portal.21.dblayer.com:10444/facetdb -u facetadmin -pTurnf34ragainst!


mongodb://facet:<password>@aws-us-east-1-portal.21.dblayer.com:10444/facetdb?ssl=true


notes
    member matching on edit page
    check in process for members
    check in process for guests
        name
        email
        associated member
            notify member via text/email

todo
    remote editing mode for guest that just checked in