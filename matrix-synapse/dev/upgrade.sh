#!/bin/sh

helm upgrade matrix . -n matrix-dev -f dev-values.yaml
