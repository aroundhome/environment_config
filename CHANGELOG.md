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
