---
title: Instant object iterator in PHP
categories: [PHP, Programming]
---

If you want to have a class iterate over an array member:

{% highlight php %}
<?php
class Foo implements IteratorAggregate {
    private $data = array();

    public function add($entry) {
        $data[] = $entry;
    }

    public function getIterator() {
        return new ArrayIterator($this->data)
    }
}

$foo = new Foo;
$foo->add('bar');
$foo->add('baz');

foreach($foo as $val) {
    echo "{$val}\n";
}
{% endhighlight %}

Outputs

    bar
    baz

That's the most common use case for the `Traversible` interface in PHP I'm encountering and it's much easier than implement the whole `Iterator` interface.
