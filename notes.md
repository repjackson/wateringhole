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


<!--autocomplete add tag to doc-->
<!--bookmarks-->
<!--cancel edit option-->
<!--shareable address-->
<!--me button-->

logan version
<!--generate cloud after update-->
matched users
take in filter
find all users with tag in tag cloud
from that set find all users with matching tags in tag list
filter tags 

todo
-tags on register
-active location


meet the people you want to know
should be fun



mongo --ssl --sslAllowInvalidCertificates aws-us-east-1-portal.21.dblayer.com:10444/facetdb -u <user> -p<password>


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