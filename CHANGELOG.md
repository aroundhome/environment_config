## 1.1.0

* Add `EnvironmentConfig.ensure`, which is a more expressive way to
  check the presence of environment variables without using them
* Improve error readout for unparsable integer

## 1.0.1

* Make method private that should never have been public
    * The `store` and `fetch` methods are not really part of the public interface
      of the config, however since `fetch` is equal to a method on hashes,
      it is quite likely to be called by accident

## 1.0.0

* Initial release
