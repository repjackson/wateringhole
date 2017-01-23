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

<!--lasdt name-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        doc.profile.last_name = doc["profile"]["LAST NAME"];
        db.users.save(doc);
    }
)


<!--lasdt name-->
db.users.find({ profile: {$exists:true} }).forEach(
    function(doc) {
        split_tags = doc.profile.tags[0].toLowerCase().split(",");
        doc.tags = split_tags;
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