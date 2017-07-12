#!/bin/bash

set -e

elm test

rm -rf build
cp -rp web build

elm-make src/Main.elm --warn --output build/app/main.js

printf "\nSite built at ./build\n\n"
