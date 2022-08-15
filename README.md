# openGauss-webclient

Web-based openGauss database browser written in Go.

*Note: This project is a fork and modified version of [pgweb](https://github.com/sosedoff/pgweb)*

## Overview

openGauss-webclient is a web-based database browser for openGauss, written in Go and works
on OSX, Linux and Windows machines. Main idea behind using Go for backend development
is to utilize ability of the compiler to produce zero-dependency binaries for 
multiple platforms. openGauss-webclient was created as an attempt to build very simple and portable
application to work with local or remote openGauss databases.


## Features

- Cross-platform support OSX/Linux/Windows 32/64-bit
- Simple installation (distributed as a single binary)
- Zero dependencies
- SSH Connections
- Multiple database sessions
- Simple database browser
- Execute and analyze custom SQL queries
- Table and query data export to CSV/JSON/XML
- Query history
- Server bookmarks

## Usage

Start server:

```
openGauss-webclient
```

You can also provide connection flags:

```
openGauss-webclient --host localhost --user myuser --db mydb
```

Connection URL scheme is also supported:

```
openGauss-webclient --url opengauss://user:password@host:port/database?sslmode=[mode]
openGauss-webclient --url "opengauss:///database?host=/absolute/path/to/unix/socket/dir"
```

### Multiple database sessions

To enable multiple database sessions in pgweb, start the server with:

```
openGauss-webclient --sessions
```

Or set environment variable:

```
SESSIONS=1 openGauss-webclient
```


## Build from source

Go 1.7 is required. You can install Go with `DNF`:

```
dnf install -y golang
```

To compile source code run the following command:
```
make setup
make dev
```

This will produce openGauss-webclient binary in the current directory.

There's also a task to compile banaries for other operating system:
```
make release
```

Compiled binaries will be stored into ./bin directory.


## Testing

Before running tests, make sure you have openGauss server running on `localhost:5432`
interface. Also, you must have `openGauss` user with password `Gaussdb_123` that could create new databases
in your local environment. openGauss-webclient server should not be running at the same time.

Execute test suite:

```
make test
```

If you're using Docker locally, you might also run pgweb test suite against
all supported openGauss version with a single command:

```
make test-all
```

## Contribute

- Fork this repository
- Create a new feature branch for a new functionality or bugfix
- Commit your changes
- Execute test suite
- Push your code and open a new pull request

## License

The MIT License (MIT). See [LICENSE](LICENSE) file for more details.
