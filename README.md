# EnvironmentConfig

This gem provides a unified way to read configuration parameters
from environment variables.


## Defining a configuration

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

## Using a configuration

After building the configuration, your values will be available:

* as methods on the config object
* as hash with string keys using `to_string_h`
* as hash with symbol keys using `to_symbol_h`

All keys are lower cased, so `FOO_ARG` will become `config.foo_arg` or `config.to_string_h['foo']`.

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
