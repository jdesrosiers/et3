Tic Tac Toe
===========

A Tic Tac Toe game written in Elm.

Setup
-----

Make sure you have elm and elm-test installed

```bash
npm install -g elm elm-test
```

Install dependencies

```bash
elm package install
```

Build
-----

The build script will run tests and build the site to the `./build` directory.

```bash
bin/build.sh
```

The `./build` directory will contain a static site that can be be viewed with any server that serves static web pages.  I use the following because it is easy and familiar, but any server will do.

```bash
php -S localhost:8000 -t build/
```
