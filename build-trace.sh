#!/bin/bash

# Builds and runs the given benchmark for trace-based pattern matching. Uses the
# test input to reduce trace size. Picks up the compiler from the CC environment
# variable.

BENCHMARK=$1

source ./env.sh

parsecmgmt -a fullclean -p $BENCHMARK
# The above line does not always do the job, for some reason.
rm pkgs/apps/$BENCHMARK/run -rf
rm pkgs/apps/$BENCHMARK/inst -rf

parsecmgmt -a build -p $BENCHMARK -c discovery -j 20
parsecmgmt -a run -p $BENCHMARK -i test -c discovery
cp pkgs/apps/$BENCHMARK/run/trace $BENCHMARK.trace
