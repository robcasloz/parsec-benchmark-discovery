#!/bin/bash

# Builds and runs the benchmark suite for trace-based pattern matching. Uses the
# test input to reduce trace size. Picks up the compiler from the CC environment
# variable.

source ./env.sh

for APP in blackscholes freqmine
do
    parsecmgmt -a fullclean -p $APP
    # The above line does not always do the job, for some reason.
    rm pkgs/apps/$APP/run -rf
    rm pkgs/apps/$APP/inst -rf

    parsecmgmt -a build -p $APP -c discovery -j 20
    parsecmgmt -a run -p $APP -i test -c discovery
    cp pkgs/apps/$APP/run/trace $APP.trace
done
