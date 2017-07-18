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

The `./build` directory will contain a static site that can be be viewed with any server that serves static web pages.  I use the following because it's easy and familiar, but any server will do.

```bash
php -S localhost:8000 -t build/
```

Implementation Notes
--------------------
I designed the app to be able to support any two player Tic Tac Toe like game.  For example, to create 4x4 Tic Tac Toe, you only need to provide an HTML `view` and the game's `Rules`.  Everything else should just work.

The AI uses a depth limited minimax algorithm with alpha-beta pruning.
