#!/bin/bash

set -euxo pipefail
cd `git rev-parse --show-toplevel`

mix clean
mix format --check-formatted
mix coveralls
mix credo -a --strict
mix dialyzer
