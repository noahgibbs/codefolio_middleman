---
title: "How Does Rack Parse Query Params? With parse_nested_query"
date: 2012-06-29 12:38
disqus_id: "http://codefol.io/posts/9"
---
What turns URL params like <code>http://site.com/people?name=bobo</code> into <code>{ :name => "bobo" }</code> in Ruby?

And what turns extra-weird Rails or Sinatra params like <code>/path?people[][name]=bobo&people[][first_love]=cheese</code>?

<h2>What the Hell is that?</h2>

Googling "rails query param names with square brackets" doesn't help much. And Rails doesn't make it easy to find docs for this.

So what's going on with the weird params?

Rails uses <a href="http://rack.github.com">Rack</a> to parse them, so it's (mostly) the same in <a href="http://sinatrarb.com">Sinatra</a>, <a href="http://padrinorb.com">Padrino</a> or your <a href="http://rebuilding-rails.com">ruby web framework of choice</a> as well.

<h2> What Does the Code Say? </h2>

Rack is really poorly documented. But the query param code is short, so instead of my usual <a href="http://rebuilding-rails.com">&quot;rebuild it&quot;</a> approach, let's go right to <a href="https://github.com/rack/rack/blob/master/lib/rack/utils.rb">the source - Rack::Utils.parse\_nested\_query</a>:

``` ruby
def parse_nested_query(qs, d = nil)
  params = KeySpaceConstrainedParams.new

  (qs || '').split(d ? /[#{d}] */n : DEFAULT_SEP).each do |p|
    k, v = p.split('=', 2).map { |s| unescape(s) }

    normalize_params(params, k, v)
  end

  return params.to_params_hash
end
```

That's just parsing the parameters by splitting on <a href="http://en.wikipedia.org/wiki/Ampersand">ampersand</a> and semicolon. What about the square braces?  They're handled in <code>normalize_params</code> (see below for abridged source, or GitHub for full). It gets called once for each parameter name.

<h2> What Does normalize_params Do? </h2>

First it checks the param name for anything that's not square-braces, and then read whatever is after that (called "after").

If the "after" is nothing there are no square braces -- great, assign the parameter, you're done.

If "after" is empty square-braces, that parameter is an array. Start with it being an empty array, and then append to it. So if you parsed <code>p[]=a&amp;p[]=b&amp;p[]=c</code>, you'd get <code>{&quot;p&quot; =&gt; [&quot;a&quot;, &quot;b&quot;, &quot;c&quot;] }</code>.

If "after" starts with empty square braces and then has more after it, it's nested. So the parameter is still an array, and could be something like an array of arrays. The code handles this by recursing.

So if you parsed <code>p[][a]=a&amp;p[][b]=b&amp;p[][c]=c</code>, you'd get <code> { &quot;p&quot; =&gt; [{ &quot;a&quot; =&gt; &quot;a&quot;, &quot;b&quot; =&gt; &quot;b&quot;, &quot;c&quot; =&gt; &quot;c&quot;]}</code>.

Feeling a little confused?  Scroll down for another approach -- play with it in irb!

``` ruby
def normalize_params(params, name, v = nil)
  name =~ %r(\A[\[\]]*([^\[\]]+)\]*)
  k = $1 || ''
  after = $' || ''

  return if k.empty?

  if after == ""
    params[k] = v
  elsif after == "[]"
    params[k] ||= []
    params[k] << v
  elsif after =~ %r(^\[\]\[([^\[\]]+)\]$) || after =~ %r(^\[\](.+)$)
    child_key = $1
    params[k] ||= []
    if params_hash_type?(params[k].last)
      && !params[k].last.key?(child_key)
      normalize_params(params[k].last, child_key, v)
    else
      params[k] << normalize_params(params.class.new, child_key, v)
    end
  else
    params[k] ||= params.class.new
    params[k] = normalize_params(params[k], after, v)
  end

  return params
end
```

<h2> Using irb </h2>

Since this is Ruby, pop open irb and <code>require "rack"</code>.

We'll define a convenience function called p() because I hate typing.

Then we'll check to make sure we were right up above:

``` ruby
Athanor:rulers noah$ irb
1.9.3p125 :001 > require "rack"
 => true 
1.9.3p125 :002 > def p(params)
1.9.3p125 :003?>   Rack::Utils.parse_nested_query(params)
1.9.3p125 :004?>   end
 => nil 
1.9.3p125 :005 > p("p[]=a&p[]=b&p[]=c")
 => {"p"=>["a", "b", "c"]} 
1.9.3p125 :006 > p("p[][a]=a&p[][b]=b&p[][c]=c")
 => {"p"=>[{"a"=>"a", "b"=>"b", "c"=>"c"}]}
```

Looks pretty good. Let's try skipping the first open brackets:

```ruby
1.9.3p125 :007 > p("p[x]=1&p[y]=2")
 => {"p"=>{"x"=>"1", "y"=>"2"}} 
1.9.3p125 :008 > p("p[123]=bobo")
 => {"p"=>{"123"=>"bobo"}} 
```

So that's what we usually see in Rails with a structure.

What else can we get by playing with this?

```ruby
1.9.3p125 :017 > p("x[][y][w]=1&x[][z]=2&x[][y][w]=3&x[][z]=4")
 => {"x"=>[{"y"=>{"w"=>"3"}, "z"=>"2"}, {"z"=>"4"}]} 
1.9.3p125 :018 > p("x[][z][w]=1&x[][z]=2&x[][y][w]=3&x[][z]=4")
 => {"x"=>[{"z"=>{"w"=>"1"}}, {"z"=>"2", "y"=>{"w"=>"3"}}, {"z"=>"4"}]} 
1.9.3p125 :019 > p("x[][z][w]=1&x[][z][j]=2&x[][y][w]=3&x[][z]=4")
 => {"x"=>[{"z"=>{"w"=>"1", "j"=>"2"}, "y"=>{"w"=>"3"}}, {"z"=>"4"}]} 
1.9.3p125 :020 > p("x[][z][w]=1&x[][z][j]=2&x[][y][w]=3&x[][b]=4")
 => {"x"=>[{"z"=>{"w"=>"1", "j"=>"2"}, "y"=>{"w"=>"3"}, "b"=>"4"}]} 
```

Have fun!  I hope you've learned some interesting things about Rack parameter parsing... And how to figure it out next time you see somebody doing something that looks complicated with Rails parameters!
