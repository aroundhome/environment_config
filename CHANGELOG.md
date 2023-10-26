## 2.0.0

* Breaking: Dropped support for Ruby versions below 3
* Fix support for Ruby versions 3 and above in some cases (e.g. support for Base64 encoded environment variables)

## 1.5.0

* Add support for a new datatype `integer_list`

## 1.4.0

* Allow passing Base64 encoded variables

## 1.3.0

* Fix a bug where it was possible to overwrite values
* Add a ?-version to retrieve boolean values

## 1.2.1

* Switch from defining methods using `method_missing` to `define_method`
(to increase compatibility with gems that rely on `method_missing` on a global level)

## 1.2.0

* Add support for complex datatypes via `json` and `yaml` parsers

## 1.1.0

* Add `EnvironmentConfig.ensure`, which is a more expressive way to
  check the presence of environment variables without using them
* Add `EnvironmentConfig.fetch_*` methods that will fetch a single
  environment variable expecting the given type (e.g. `fetch_string`).
* Improve error readout for unparsable integer

## 1.0.1

* Make method private that should never have been public
    * The `store` and `fetch` methods are not really part of the public interface
      of the config, however since `fetch` is equal to a method on hashes,
      it is quite likely to be called by accident

## 1.0.0

* Initial release
