# Tunitas Apanolio

This repository contains a reference implementation of the "North-Facing" API service for the Interactive Advertising Bureau's (IAB) [PrivacyChain](https://github.com/InteractiveAdvertisingBureau/PrivacyChain). It is an an application hosted within the [Apache HTTPd](https://httpd.apache.org/) server.  As such, it is a "<em>macro</em>service" approach to delivering the north-facing API services.

The main body of documentation for the Tunitas family of components and services can be found with the [packaging](https://github.com/yahoo/tunitas-packaging) and with [build system](https://github.com/yahoo/temerarious-flagship]).  The overview and administrative declarations herein are necessarily summary in nature. The declarations and definitions in the packaging and build system areas are complete and should be interpreted as superceding these when the two are in conflict.

![banner](logo.png)

## Table of Contents

- [Background](#background)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Configuration](#configuration)
- [Build](#build)
- [Usage](#usage)
- [API](#api)
- [Security](#security)
- [References](#references)
- [Contribute](#contribute)
- [License](#license)
- [Origin of the Name](#Origin_of_the_name)

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

## Background

The Apanolio implements the "Northbound API" of the  Interactive Advertising Bureau's (IAB) [PrivacyChain](https://github.com/InteractiveAdvertisingBureau/PrivacyChain).  Depending on which database backends are configured into the system, various levels of scalability, redundancy and persistenc will be obtained.  There are drivers for in memory operation, "shared nothing" NoSQL databases, traditional multi-tier SQL as well as more exotic data base systems.  Not all of the potential storage systems are implemented at this point

Potential storage technologies are:
* LevelDB
* SQLite
* MySQL
* PosgreSQL (PgSQL)
* RAMCloud
* State Space and Hyperledger Fabric (or a compatible PrivacyChain "Southside")

Depending on how the service is configured, your build may need one of the following database system for the "Southside" interface.

## Dependencies

The [configuration](#configuration) step will check for many but not all required packages and operating system features.  There is a list of known [package-dependencies](https://github.com/yahoo/tunitas-butano/blob/master/PACKAGES.md) which you will need to install beyond your base operating system.

Generally, the dependencies are among:
- Certain other components of the Tunitas system; <em>e.g.</em> the [Basic Components](https://github.com/yahoo/tunitas-basic).
- A modern (C++2a) development environment.
- A recent Fedora, but any recent Linux distro should suffice.

The Tunitas project was developed on Fedora 27 through Fedora 30 using GCC 7 and GCC 8 with `-fconcepts` and at least `-std=c++1z`.  More details on the development environment and the build system can be found in [temerarious-flagship](https://github.com/yahoo/temerarious-flagship/blob/master/README.md).

## Installation

You may install this repo and its dependents by running the following command:

``` bash
git clone https://github.com/yahoo/tunitas-apanolio.git
```

This will create a directory called `tunitas-apanolio` and download the contents of this repo to it.

Alternatively, if your organization already has made available the packaged version, then the following recipe will install the service:

``` bash
sudo dnf install tunitas-apanolio
```

## Configuration

The build system is based upon [GNU Autotools](https://www.gnu.org/software/automake/manual/html_node/index.html).

The configuration of the repo consists of two steps which must be done once.
1. `./buildconf`
2. `./configure`

The first step performs some crude assessments of the build environment and creates the site-specific `configure'. Of course `configure --help` will explain the build options.  The general options to `configure` are widely [documented](https://www.gnu.org/prep/standards/html_node/Configuration.html).

The `buildconf` component is boilerplate and can be updated from [temerarious-flagship](https://github.com/yahoo/temerarious-flagship/blob/master/bc/template.autotools-buildconf) as needed.  The [Tunitas Build System](https://github.com/yahoo/temerarious-flagship) should be available in `/opt/tunitas` and the template at `/opt/tunitas/share/temerarious-flagship/bc/template.autotools-buildconf`

## Build

The service can be built with the following recipe:

``` bash
./buildconf &&
./configure &&
make &&
make check &&
make install &&
echo OK DONE
```

## Usage

The configuration of the service is through the systemd unit files of Apache's HTTPd.  A typical service initiation would look as follows:

``` bash
systemctl enable httpd
systemctl start httpd
```

## References

### IAB PrivacyChain

Documents pertaining to the the [IAB PrivacyChain](https://github.com/InteractiveAdvertisingBureau/PrivacyChain) operation and governance as well as a separate reference implementation of the Technology Specification are available at the [main site](https://github.com/InteractiveAdvertisingBureau).

### Northbound API

The Apanolio service implements the [IAB PrivacyChain](https://github.com/Interactive-Advertising-Bureau/PrivacyChain) "Northbound" REST API.
The authoritative specification of this API can be found the IAB as [REST-API](https://github.com/Interactive-Advertising-Bureau/PrivacyChain/blob/master/doc/REST-API.md).

### Southside Interfaces

The [State Space PrivacyChain API](https://github.com/yahoo/PrivacyChain-sdk-c++) is a conforming interface for the Hyperledger Fabric.

### Server Container

* [Apache HTTPd](https://httpd.apache.org/)
* [apache/httpd](https://github.com/apache/httpd)

## Security

The Apaniolo service is intended to facilitate access to a data base technology which conforms to the IAB's PrivacyChain technology specification. It is intended to be operated from within secure facilities in support of consumer-facing applications.  It is _not_ intended for direct exposure to the internet.  Best practices for intra-datacenter (micro-)service secure options are expected.  These practices include at least the use of TLS and controlled access networks.

## Contribute

Please refer to [the contributing.md file](Contributing.md) for information about how to get involved. We welcome issues, questions, and pull requests. Pull Requests are welcome.

## Maintainers
- Wendell Baker <wbaker@verizonmedia.com>
- The Tunitas Team at Verizon Media.

You may contact us at least at <tunitas@verizonmedia.com>

## License

This project is licensed under the terms of the [Apache 2.0](LICENSE-Apache-2.0) open source license. Please refer to [LICENSE](LICENSE) for the full terms.

### Origin of the Name

Apanolio is a [Creek](https://en.wikipedia.org/wiki/Apanolio_Creek) is located in San Mateo County, California. It is a tributary of [Pilarcitos Creek](https://en.wikipedia.org/wiki/Pilarcitos_Creek).
