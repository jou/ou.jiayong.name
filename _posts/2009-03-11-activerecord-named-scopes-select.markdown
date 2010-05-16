---
title: ActiveRecord, named scopes, select statements and you
categories: [Ruby, Programming]
---

ActiveRecord’s [named_scope][1]s are awesome, but I recently run into something less awesome about it: It doesn’t merge the `:select` option of nested scopes.
 

So let’s look something like that:

{% highlight ruby %}
class Profile::Business < Profile::Profile
  # ... some code ...

  named_scope(:by_popularity, 
    :select => "profile_profiles.*, count(profile_fans.member_id) AS fan_count",
    # ... some more stuff for the scope
    :order => "fan_count DESC"
  )

  # ... some more code ...
end
{% endhighlight %}

And we use the named scope like this:
 
{% highlight ruby %}
Profile::Business.by_popularity.find(:all, :select => 'profile_profile.*')
{% endhighlight %}

Should work, shouldn’t it? But as you might have guessed, it’s where ActiveRecord is exploding by throwing an `ActiveRecord::StatementInvalid` exception:

    Mysql::Error: Unknown column 'fan_count' in 'order clause':
    
If you look at the rails log, you should see something like that:

    Profile::Business Load (0.017810) SELECT profile_profiles.* FROM `profile_profiles` INNER JOIN [... some more SQL ...]
    
Yes, my first though was ‘Dude, where’s my SELECT?’. Turns out ActiveRecord doesn’t merge them it just use the last `:select` it encounters. In my case the workaround was easy by moving the `COUNT()` from `:select` to `:order`:
 
{% highlight ruby %}
class Profile::Business < Profile::Profile
  # ... some code ...

  named_scope(:by_popularity, 
    :select => "profile_profiles.*",
    # ... some more stuff for the scope
    :order => "count(profile_fans.member_id) DESC"
  )

  # ... some more code ...
end
{% endhighlight %}
    
Crisis averted in this case, but it still leaves an uneasy feeling. And of course, the documentation says nothing about that.

Oh well… Someone [proposed a patch][2] for this problem and let’s hope it makes it into a Rails release.

 [1]: http://api.rubyonrails.org/classes/ActiveRecord/NamedScope/ClassMethods.html#M002120
 [2]: http://rails.lighthouseapp.com/projects/8994/tickets/1295-making-with_scope-merge-selects
