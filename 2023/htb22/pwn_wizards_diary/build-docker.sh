#!/bin/sh
docker build --tag=wizards_diary .
docker run -it -p 1337:1337 --rm --name=wizards_diary wizards_diary