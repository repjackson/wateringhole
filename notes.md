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
be undeniable



mongo --ssl --sslAllowInvalidCertificates aws-us-east-1-portal.21.dblayer.com:10444/facetdb -u <user> -p<password>


revenue
    consumer
        blogging platform
        twitter replacement
        wikipedia competitor
        subscription
            $10/month
    enterprise
        $1000 per
            webs    ite
                wordpress clone
                wysiwyg
                facet structure
                advantages
                    facet integration
                    modules (updated)
        goal is $10,000 per
    


freelancer site
    post offers
    offer
        tags
        description
        price
    submit proposal
        
        
        
level up in life
competitors
    wix
    wordpress
    medium
    facebook
    fivrr
    classifieds for gold run
    
    
look at it from need perspectives
    gold run
        classifieds
            craigslist alternative
    impact hub
        membership
        services
    paul
        consultant services
        profile
        resume
    bike loaner
        volunteer management
    technotrainer
        client management
        
        
        
what if dating app was a game

uplevel with intellect
we make life a game
the rules are crowdsourced

start with the concept that intellect ranks you higher



todo
    message page
    function like a chat, look like email

    
watering hole
    private tag
    private site
    cost $100 month
    
    
    
facet
    tags controlled by middleware,
    find people, contact them
    
    
wh admin
    integrations
        importing from
        exporting to
    crm system
    
    
thoughts
    emmett needs a spreadsheet replacement, top priority
    people management, import, move around, find things, export
    crm system
    
structure
