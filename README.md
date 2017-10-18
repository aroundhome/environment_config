# EnvironmentConfig

This gem provides a unified way to read configuration parameters
from environment variables.


## Usage

You can load a configuration from the environment using a `load` block:

```ruby
config = EnvironmentConfig.load do |c|
  c.string 'FOO'
  c.integer 'BAR', 42
end
```

If any required variable is missing, an error will be raised. Errors can be
suppressed by providing a default value as second parameter.

Albeit environment variables being string only, you can specify types when
defining parameters:

* `string`
* `symbol`
* `integer` (base 10 encoded)
* `boolean` (only accepts `true` and `false`)
* `string_list` (comma separated)

Type conversions try to be strict and will throw an error, if the conversion
can't be performed safely (e.g. an integer receiving `abc` will raise an error
instead of parsing to `0`).

### Accessing values

After building the configuration, your values will be available:

* as methods on the config object
* as hash with string keys using `to_string_hash`
* as hash with symbol keys using `to_symbol_hash`

All keys are lower cased, so `FOO_ARG` will become `config.foo_arg` or `config.to_string_hash['foo']`.

### Avoiding prefix duplication

For environment variables you will usually want to assign common prefixes, e.g.

```bash
export FOO_HOST=host
export FOO_PASSWORD=password
```

Oftentimes you don't want to have those prefixes in your application config,
so you can strip them using `strip_prefix`:

```ruby
# defining it
foo_config = EnvironmentConfig.load(strip_prefix: 'FOO_') do |c|
  c.string  'FOO_HOST', 'default_host'
  c.string  'FOO_PASSWORD'
  c.string  'OTHER_FOO_VALUE', 'test'
end

# using it
foo_config.host # default_host
foo_config.other_foo_value # test
```

### Accessing single values

Sometimes you just want to fetch a few unrelated values from the environment,
but not create a configuration object.

There are fetch methods for all known types. For example:

```ruby
EnvironmentConfig.fetch_integer('MY_PORT')
 => 42
```

### Expecting environment variables

If you want to check the correct definition of environment variables that you do
not consume yourself (e.g. you know that a gem will consume them), just use
the `ensure` helper method:

```ruby
EnvironmentConfig.ensure do |c|
  c.string  'MY_GEM_CONFIG_VALUE'
  c.integer 'MY_GEM_OTHER_VALUE'
end
```

### Integration with Rails

One possible integration into a Rails application could look like this:

```ruby
# config/application.rb
module MyRailsApp
  class Application < Rails::Application
    # ...

    config.some_sub_configuration = EnvironmentConfig.load do |c|
      c.string  'FOO_HOST', 'default_host'
      c.string  'FOO_PASSWORD'
      c.boolean 'SOME_BOOL', false
    end
  end
end

# somewhere else
Rails.application.config.some_sub_configuration.foo
```
