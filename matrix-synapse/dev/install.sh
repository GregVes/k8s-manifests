#!/bin/sh

helm install matrix . -n matrix-dev -f dev-values.yaml
