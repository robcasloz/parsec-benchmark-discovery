#!/bin/bash

# Builds and runs the benchmark suite for trace-based pattern matching. Uses the
# test input to reduce trace size.

source ./env.sh
parsecmgmt -a fullclean -p blackscholes
# The above line does not always do the job, for some reason.
rm pkgs/apps/blackscholes/run -rf
rm pkgs/apps/blackscholes/inst -rf

parsecmgmt -a build -p blackscholes -c discovery
parsecmgmt -a run -p blackscholes -i test -c discovery
cp pkgs/apps/blackscholes/run/trace blackscholes.trace
