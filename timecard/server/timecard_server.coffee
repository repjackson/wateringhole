Meteor.publish 'timecard', (user_id)->
    Docs.find
        author_id: user_id
        type: 'timecard'
        
        
Meteor.methods
    'calculate_user_totals': (user_id)->
        user = Meteor.users.findOne user_id
        
        now = new Date()
        this_month = now.getMonth() + 1
        
        match = {}
        match.author_id = user_id
        match.type = 'timecard'
        match.tags = $in: ['in']
        
        agg = Docs.aggregate [
            { $match: match }
            { $project:
                # year: $year: '$timestamp'
                month: $month: '$timestamp'
                day: $dayOfMonth: '$timestamp'
                # hour: $hour: '$timestamp'
                # minutes: $minute: '$timestamp'
                # seconds: $second: '$timestamp'
                # milliseconds: $millisecond: '$timestamp'
                # dayOfYear: $dayOfYear: '$timestamp'
                # dayOfWeek: $dayOfWeek: '$timestamp'
                # week: $week: '$timestamp' 
            }
            { $match: month: this_month }

            # { $group: _id: '$month', count: $sum: 1 }
            { $group: _id: '$day', count: $sum: 1 }

        ]

        # console.log agg.length

        monthly_day_usage = agg.length
        
        Meteor.users.update user_id,
            $set: monthly_day_usage: monthly_day_usage