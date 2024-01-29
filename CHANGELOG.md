# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/1.2.0) (2024-01-29)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/1.1.0...1.2.0)

**Implemented enhancements:**

- Support facts by symbol [\#87](https://github.com/voxpupuli/puppet-ghostbuster/pull/87) ([h0tw1r3](https://github.com/h0tw1r3))
- support for hiera datadir [\#86](https://github.com/voxpupuli/puppet-ghostbuster/pull/86) ([h0tw1r3](https://github.com/h0tw1r3))
- optimize puppetdb query [\#85](https://github.com/voxpupuli/puppet-ghostbuster/pull/85) ([h0tw1r3](https://github.com/h0tw1r3))
- optimize search file content [\#84](https://github.com/voxpupuli/puppet-ghostbuster/pull/84) ([h0tw1r3](https://github.com/h0tw1r3))
- support puppetdb token authentication [\#73](https://github.com/voxpupuli/puppet-ghostbuster/pull/73) ([h0tw1r3](https://github.com/h0tw1r3))

**Fixed bugs:**

- Getting 'ArgumentError: invalid byte sequence in UTF-8' when using ghostbuster\_facts [\#63](https://github.com/voxpupuli/puppet-ghostbuster/issues/63)

**Merged pull requests:**

- Update voxpupuli-rubocop requirement from ~\> 2.3.0 to ~\> 2.4.0 [\#82](https://github.com/voxpupuli/puppet-ghostbuster/pull/82) ([dependabot[bot]](https://github.com/apps/dependabot))
- Update voxpupuli-rubocop requirement from ~\> 2.2.0 to ~\> 2.3.0 [\#81](https://github.com/voxpupuli/puppet-ghostbuster/pull/81) ([dependabot[bot]](https://github.com/apps/dependabot))

## [1.1.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/1.1.0) (2024-01-08)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/1.0.0...1.1.0)

Due to problems during the migration from the camptocamp GitHub org to Vox Pupuli we had some issues with the v1.0.0 Release. The tag exists but the release isn't available on rubygems.org.

**Merged pull requests:**

- reorder gems in Gemfile/gemspec [\#78](https://github.com/voxpupuli/puppet-ghostbuster/pull/78) ([bastelfreak](https://github.com/bastelfreak))
- Set minimal Ruby version to 2.7 [\#77](https://github.com/voxpupuli/puppet-ghostbuster/pull/77) ([bastelfreak](https://github.com/bastelfreak))

## [1.0.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/1.0.0) (2023-11-11)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.9.0...1.0.0)

**Breaking changes:**

- Support hiera v5 [\#75](https://github.com/voxpupuli/puppet-ghostbuster/pull/75) ([marek130](https://github.com/marek130))

**Closed issues:**

- Can we bump this module to support puppet-lint \> 3? [\#67](https://github.com/voxpupuli/puppet-ghostbuster/issues/67)

**Merged pull requests:**

- Bump actions/checkout from 3 to 4 [\#72](https://github.com/voxpupuli/puppet-ghostbuster/pull/72) ([dependabot[bot]](https://github.com/apps/dependabot))
- added some unsafe rubocop fixes [\#71](https://github.com/voxpupuli/puppet-ghostbuster/pull/71) ([zilchms](https://github.com/zilchms))
- Update puppet-lint requirement from \>= 1.0, \< 3.0 to \>= 1.0, \< 5.0 [\#70](https://github.com/voxpupuli/puppet-ghostbuster/pull/70) ([dependabot[bot]](https://github.com/apps/dependabot))
- modulesync 2023-8-23 [\#69](https://github.com/voxpupuli/puppet-ghostbuster/pull/69) ([zilchms](https://github.com/zilchms))
- add transfer notice to README; adjust gemspec accordingly [\#68](https://github.com/voxpupuli/puppet-ghostbuster/pull/68) ([zilchms](https://github.com/zilchms))
- Use default certificate locations [\#65](https://github.com/voxpupuli/puppet-ghostbuster/pull/65) ([raphink](https://github.com/raphink))
- typo fix in the readme file [\#64](https://github.com/voxpupuli/puppet-ghostbuster/pull/64) ([Sher-Chowdhury](https://github.com/Sher-Chowdhury))

## [0.9.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.9.0) (2017-08-18)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.8.0...0.9.0)

**Merged pull requests:**

- Use PQL [\#62](https://github.com/voxpupuli/puppet-ghostbuster/pull/62) ([raphink](https://github.com/raphink))

## [0.8.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.8.0) (2016-09-23)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.7.3...0.8.0)

**Closed issues:**

- Conflicts with puppet-lint 2 [\#61](https://github.com/voxpupuli/puppet-ghostbuster/issues/61)

## [0.7.3](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.7.3) (2016-06-08)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.7.2...0.7.3)

**Fixed bugs:**

- \[Hiera\_files\] False positive when fact is boolean [\#59](https://github.com/voxpupuli/puppet-ghostbuster/issues/59)

**Merged pull requests:**

- Convert fact value to boolean \(fixes \#59\) [\#60](https://github.com/voxpupuli/puppet-ghostbuster/pull/60) ([mcanevet](https://github.com/mcanevet))

## [0.7.2](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.7.2) (2016-05-19)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.7.1...0.7.2)

**Fixed bugs:**

- Facts used in inline\_templates are not detected [\#53](https://github.com/voxpupuli/puppet-ghostbuster/issues/53)

**Merged pull requests:**

- Detect facts used in inline\_template \(fixes \#53\) [\#54](https://github.com/voxpupuli/puppet-ghostbuster/pull/54) ([mcanevet](https://github.com/mcanevet))

## [0.7.1](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.7.1) (2016-05-16)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.7.0...0.7.1)

**Merged pull requests:**

- Use puppetdb instead of manifests for unused types detection [\#52](https://github.com/voxpupuli/puppet-ghostbuster/pull/52) ([mcanevet](https://github.com/mcanevet))

## [0.7.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.7.0) (2016-05-16)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.6.0...0.7.0)

**Implemented enhancements:**

- Plugin to detect unused facts [\#45](https://github.com/voxpupuli/puppet-ghostbuster/issues/45)
- Plugin to detect unused types [\#44](https://github.com/voxpupuli/puppet-ghostbuster/issues/44)
- Plugin to detect unused functions [\#43](https://github.com/voxpupuli/puppet-ghostbuster/issues/43)

**Closed issues:**

- Use fixtures for puppetdb calls [\#42](https://github.com/voxpupuli/puppet-ghostbuster/issues/42)

**Merged pull requests:**

- Detect unused types \(fixes \#44\) [\#51](https://github.com/voxpupuli/puppet-ghostbuster/pull/51) ([mcanevet](https://github.com/mcanevet))
- Detect unused functions \(fixes \#43\) [\#50](https://github.com/voxpupuli/puppet-ghostbuster/pull/50) ([mcanevet](https://github.com/mcanevet))
- Use fixtures for puppetdb queries [\#49](https://github.com/voxpupuli/puppet-ghostbuster/pull/49) ([mcanevet](https://github.com/mcanevet))
- Detect unused facts \(fixes \#45\) [\#46](https://github.com/voxpupuli/puppet-ghostbuster/pull/46) ([mcanevet](https://github.com/mcanevet))

## [0.6.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.6.0) (2016-05-12)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.5.1...0.6.0)

**Implemented enhancements:**

- Plugin to detect unused hiera files [\#26](https://github.com/voxpupuli/puppet-ghostbuster/issues/26)

**Merged pull requests:**

- Detect unused hiera files \(fixes \#26\) [\#48](https://github.com/voxpupuli/puppet-ghostbuster/pull/48) ([mcanevet](https://github.com/mcanevet))

## [0.5.1](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.5.1) (2016-05-11)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.5.0...0.5.1)

**Implemented enhancements:**

- Use fixtures for unit tests [\#38](https://github.com/voxpupuli/puppet-ghostbuster/issues/38)
- Detect templates included in templates [\#37](https://github.com/voxpupuli/puppet-ghostbuster/issues/37)

**Fixed bugs:**

- Module path with ending slash cause an error [\#13](https://github.com/voxpupuli/puppet-ghostbuster/issues/13)

**Closed issues:**

- non-ssl fails [\#14](https://github.com/voxpupuli/puppet-ghostbuster/issues/14)

**Merged pull requests:**

- Detect templates included in templates \(Fix \#37\) [\#41](https://github.com/voxpupuli/puppet-ghostbuster/pull/41) ([mcanevet](https://github.com/mcanevet))
- Add a spec lib to ease PuppetDB mocking [\#40](https://github.com/voxpupuli/puppet-ghostbuster/pull/40) ([raphink](https://github.com/raphink))
- Use fixtures [\#39](https://github.com/voxpupuli/puppet-ghostbuster/pull/39) ([mcanevet](https://github.com/mcanevet))

## [0.5.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.5.0) (2016-05-10)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.4.5...0.5.0)

**Implemented enhancements:**

- refactor puppet db queries \(self.client\) [\#7](https://github.com/voxpupuli/puppet-ghostbuster/issues/7)

**Closed issues:**

- \[File\] False positive when parent dir has recurse =\> true [\#21](https://github.com/voxpupuli/puppet-ghostbuster/issues/21)
- Fix manifests filter regex [\#33](https://github.com/voxpupuli/puppet-ghostbuster/issues/33)
- Fix warning: class variable acce ss from toplevel [\#32](https://github.com/voxpupuli/puppet-ghostbuster/issues/32)
- Refactor puppet-lint plugins [\#30](https://github.com/voxpupuli/puppet-ghostbuster/issues/30)
- Fix pending unit tests [\#29](https://github.com/voxpupuli/puppet-ghostbuster/issues/29)
- Refactor using plugins \(like puppet-lint\) [\#25](https://github.com/voxpupuli/puppet-ghostbuster/issues/25)

**Merged pull requests:**

- Use a better regexp for manifests [\#34](https://github.com/voxpupuli/puppet-ghostbuster/pull/34) ([raphink](https://github.com/raphink))
- V2 refactor [\#31](https://github.com/voxpupuli/puppet-ghostbuster/pull/31) ([raphink](https://github.com/raphink))
- Use puppet-lint plugins [\#27](https://github.com/voxpupuli/puppet-ghostbuster/pull/27) ([mcanevet](https://github.com/mcanevet))
- Fix travis run \(fixes \#18\) [\#24](https://github.com/voxpupuli/puppet-ghostbuster/pull/24) ([mcanevet](https://github.com/mcanevet))

## [0.4.5](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.4.5) (2016-05-04)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.4.4...0.4.5)

## [0.4.4](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.4.4) (2016-05-04)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.4.3...0.4.4)

## [0.4.3](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.4.3) (2016-05-04)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.4.2...0.4.3)

**Merged pull requests:**

- Resource params [\#23](https://github.com/voxpupuli/puppet-ghostbuster/pull/23) ([mcanevet](https://github.com/mcanevet))
- Implement --key, --cert and --ca options [\#22](https://github.com/voxpupuli/puppet-ghostbuster/pull/22) ([Phil0xF7](https://github.com/Phil0xF7))

## [0.4.2](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.4.2) (2016-05-02)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.4.1...0.4.2)

## [0.4.1](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.4.1) (2016-05-02)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.4.0...0.4.1)

**Merged pull requests:**

- Fix unused files detection [\#20](https://github.com/voxpupuli/puppet-ghostbuster/pull/20) ([mcanevet](https://github.com/mcanevet))

## [0.4.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.4.0) (2016-04-28)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.2.1...0.4.0)

**Implemented enhancements:**

- Output to json [\#17](https://github.com/voxpupuli/puppet-ghostbuster/issues/17)

**Fixed bugs:**

- Fix unit tests [\#18](https://github.com/voxpupuli/puppet-ghostbuster/issues/18)

**Closed issues:**

- PuppetDB 3+ support [\#15](https://github.com/voxpupuli/puppet-ghostbuster/issues/15)

**Merged pull requests:**

- Output to JSON \(fixes \#17\) [\#19](https://github.com/voxpupuli/puppet-ghostbuster/pull/19) ([mcanevet](https://github.com/mcanevet))
- Configure client for PuppetDB API v4 [\#16](https://github.com/voxpupuli/puppet-ghostbuster/pull/16) ([daenney](https://github.com/daenney))

## [0.2.1](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.2.1) (2015-10-07)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.2.0...0.2.1)

**Fixed bugs:**

- Add documentation and allow relative paths in .ghostbusterignore file [\#12](https://github.com/voxpupuli/puppet-ghostbuster/pull/12) ([roidelapluie](https://github.com/roidelapluie))

## [0.2.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.2.0) (2015-10-07)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.1.4...0.2.0)

**Implemented enhancements:**

- Implement a .ghostbusterignore file [\#11](https://github.com/voxpupuli/puppet-ghostbuster/pull/11) ([roidelapluie](https://github.com/roidelapluie))

## [0.1.4](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.1.4) (2015-09-14)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.1.3...0.1.4)

**Implemented enhancements:**

- Setup automatic releases on Travis CI [\#9](https://github.com/voxpupuli/puppet-ghostbuster/issues/9)

**Fixed bugs:**

- Skip symlink files [\#10](https://github.com/voxpupuli/puppet-ghostbuster/issues/10)
- Search for files in all subfolders [\#8](https://github.com/voxpupuli/puppet-ghostbuster/pull/8) ([roman-mueller](https://github.com/roman-mueller))

## [0.1.3](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.1.3) (2015-04-23)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.1.2...0.1.3)

**Implemented enhancements:**

- add @@logger and log level option [\#5](https://github.com/voxpupuli/puppet-ghostbuster/pull/5) ([saimonn](https://github.com/saimonn))

## [0.1.2](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.1.2) (2015-04-23)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.1.1...0.1.2)

## [0.1.1](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.1.1) (2015-04-23)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.1.0...0.1.1)

**Closed issues:**

- Add support for non SSL [\#3](https://github.com/voxpupuli/puppet-ghostbuster/issues/3)

## [0.1.0](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.1.0) (2015-04-22)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.0.6...0.1.0)

**Implemented enhancements:**

- Options/parser [\#2](https://github.com/voxpupuli/puppet-ghostbuster/pull/2) ([saimonn](https://github.com/saimonn))

## [0.0.6](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.0.6) (2015-04-22)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.0.5...0.0.6)

## [0.0.5](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.0.5) (2015-04-22)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.0.4...0.0.5)

**Implemented enhancements:**

- Manage templates [\#1](https://github.com/voxpupuli/puppet-ghostbuster/pull/1) ([mcanevet](https://github.com/mcanevet))

## [0.0.4](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.0.4) (2015-04-21)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.0.2...0.0.4)

## [0.0.2](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.0.2) (2015-04-21)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0.0.1...0.0.2)

## [0.0.1](https://github.com/voxpupuli/puppet-ghostbuster/tree/0.0.1) (2015-04-21)

[Full Changelog](https://github.com/voxpupuli/puppet-ghostbuster/compare/0fb67b04292525eb0b75756da85f63ad900d2cb0...0.0.1)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
