# Spree Autosuggest

This extension adds suggestions for product search.

## Installation

1. Add the Spree Autosuggest gem to your `Gemfile`:

```ruby
gem 'spree_autosuggest'
```

2. Run:
```sh
bundle install
rails g spree_autosuggest:install
```

3. In order to add all Taxon & Product names to the autosuggest database run:
```sh
rake spree_autosuggest:seed
```

Copyright (c) 2012-2015 [ademidov][1], [divineforest][2] and other [contributors][3], released under the [New BSD License].

[1]: https://github.com/ademidov
[2]: https://github.com/divineforest
[3]: https://github.com/evrone/spree_autosuggest/graphs/contributors
