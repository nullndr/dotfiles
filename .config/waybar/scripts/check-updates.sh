#! /usr/bin/env bash

main() {
  checkupdates | wc -l
}

main $@