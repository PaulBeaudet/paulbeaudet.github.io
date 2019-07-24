#!/bin/bash
git add .
git commit -m "$1"
JEKYLL_ENV=production bundle exec jekyll build
aws s3 sync _site/ s3://paul.deabute.com --delete
git push
