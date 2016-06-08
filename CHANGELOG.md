# Change Log

## [0.7.3](https://rubygems.org/gems/puppet-ghostbuster/versions/0.7.3) (2016-06-08)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.7.2...0.7.3)

**Fixed bugs:**

- False positive when fact is boolean

## [0.7.2](https://rubygems.org/gems/puppet-ghostbuster/versions/0.7.2) (2016-05-19)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.7.1...0.7.2)

**Fixed bugs:**

- Detect facts used in inline_templates()

## [0.7.1](https://rubygems.org/gems/puppet-ghostbuster/versions/0.7.1) (2016-05-16)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.7.0...0.7.1)

**Implemented enhancements:**

- Add missing documentation.
- Use PuppetDB instead of manifests to detect unused types.

## [0.7.0](https://rubygems.org/gems/puppet-ghostbuster/versions/0.7.0) (2016-05-16)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.6.0...0.7.0)

**Implemented enhancements:**

- Detect unused facts.
- Detect unused functions.
- Detect unused types.

## [0.6.0](https://rubygems.org/gems/puppet-ghostbuster/versions/0.6.0) (2016-05-12)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.5.1...0.6.0)

**Implemented enhancements:**

- Detect unused hiera files.

## [0.5.1](https://rubygems.org/gems/puppet-ghostbuster/versions/0.5.1) (2016-05-11)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.5.0...0.5.1)

**Fixed bugs:**

- Detect templates included in templates

## [0.5.0](https://rubygems.org/gems/puppet-ghostbuster/versions/0.5.0) (2016-05-10)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.4.5...0.5.0)

**Implemented enhancements:**

- Major Reimplementation. Delivered as puppet-lint plugins.

## [0.4.5](https://rubygems.org/gems/puppet-ghostbuster/versions/0.4.5) (2016-05-04)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.4.4...0.4.5)

**Fixed bugs:**

- Don't use regex

## [0.4.4](https://rubygems.org/gems/puppet-ghostbuster/versions/0.4.4) (2016-05-04)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.4.3...0.4.4)

**Fixed bugs:**

- Fix unless/if issue

## [0.4.3](https://rubygems.org/gems/puppet-ghostbuster/versions/0.4.3) (2016-05-04)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.4.2...0.4.3)

**Fixed bugs:**

- Less false positive

## [0.4.2](https://rubygems.org/gems/puppet-ghostbuster/versions/0.4.2) (2016-05-02)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.4.1...0.4.2)

**Fixed bugs:**

- Fix variable name

## [0.4.1](https://rubygems.org/gems/puppet-ghostbuster/versions/0.4.1) (2016-05-02)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.4.0...0.4.1)

**Fixed bugs:**

- Fix unused files detection[\#20](https://github.com/camptocamp/puppet-ghostbuster/pull/20) ([mcanevet](https://github.com/mcanevet))

## [0.4.0](https://rubygems.org/gems/puppet-ghostbuster/versions/0.4.0) (2016-04-28)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.3.0...0.4.0)

**Implemented enhancements:**

- Output to JSON[\#17](https://github.com/camptocamp/puppet-ghostbuster/pull/17) ([mcanevet](https://github.com/mcanevet))

## [0.3.0](https://rubygems.org/gems/puppet-ghostbuster/versions/0.3.0) (2016-04-26)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.2.1...0.3.0)

**Fixed bugs:**

- PuppetDB 3+ support [\#16](https://github.com/camptocamp/puppet-ghostbuster/pull/16) ([daenney](https://github.com/daenney))

## [0.2.1](https://rubygems.org/gems/puppet-ghostbuster/versions/0.2.1) (2015-10-07)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.2.0...0.2.1)

**Fixed bugs:**

- Add documentation and allow relative paths in .ghostbusterignore file [\#12](https://github.com/camptocamp/puppet-ghostbuster/pull/12) ([roidelapluie](https://github.com/roidelapluie))

## [0.2.0](https://rubygems.org/gems/puppet-ghostbuster/versions/0.2.0) (2015-10-07)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.1.4...0.2.0)

**Implemented enhancements:**

- Implement a .ghostbusterignore file [\#11](https://github.com/camptocamp/puppet-ghostbuster/pull/11) ([roidelapluie](https://github.com/roidelapluie))

## [0.1.4](https://rubygems.org/gems/puppet-ghostbuster/versions/0.1.4) (2015-09-14)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.1.3...0.1.4)

**Implemented enhancements:**

- Setup automatic releases on Travis CI [\#9](https://github.com/camptocamp/puppet-ghostbuster/issues/9)

**Fixed bugs:**

- Skip symlink files [\#10](https://github.com/camptocamp/puppet-ghostbuster/issues/10)
- Search for files in all subfolders [\#8](https://github.com/camptocamp/puppet-ghostbuster/pull/8) ([roman-mueller](https://github.com/roman-mueller))

## [0.1.3](https://rubygems.org/gems/puppet-ghostbuster/versions/0.1.3) (2015-04-23)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.1.2...0.1.3)

**Implemented enhancements:**

- add @@logger and log level option [\#5](https://github.com/camptocamp/puppet-ghostbuster/pull/5) ([saimonn](https://github.com/saimonn))

## [0.1.2](https://rubygems.org/gems/puppet-ghostbuster/versions/0.1.2) (2015-04-23)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.1.1...0.1.2)

## [0.1.1](https://rubygems.org/gems/puppet-ghostbuster/versions/0.1.1) (2015-04-23)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.1.0...0.1.1)

**Closed issues:**

- Add support for non SSL [\#3](https://github.com/camptocamp/puppet-ghostbuster/issues/3)

## [0.1.0](https://rubygems.org/gems/puppet-ghostbuster/versions/0.1.0) (2015-04-22)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.0.6...0.1.0)

**Implemented enhancements:**

- Options/parser [\#2](https://github.com/camptocamp/puppet-ghostbuster/pull/2) ([saimonn](https://github.com/saimonn))

## [0.0.6](https://rubygems.org/gems/puppet-ghostbuster/versions/0.0.6) (2015-04-22)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.0.5...0.0.6)

## [0.0.5](https://rubygems.org/gems/puppet-ghostbuster/versions/0.0.5) (2015-04-22)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.0.4...0.0.5)

**Implemented enhancements:**

- Manage templates [\#1](https://github.com/camptocamp/puppet-ghostbuster/pull/1) ([mcanevet](https://github.com/mcanevet))

## [0.0.4](https://rubygems.org/gems/puppet-ghostbuster/versions/0.0.4) (2015-04-21)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.0.2...0.0.4)

## [0.0.2](https://rubygems.org/gems/puppet-ghostbuster/versions/0.0.2) (2015-04-21)
[Full Changelog](https://github.com/camptocamp/puppet-ghostbuster/compare/0.0.1...0.0.2)

## [0.0.1](https://rubygems.org/gems/puppet-ghostbuster/versions/0.0.1) (2015-04-21)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
