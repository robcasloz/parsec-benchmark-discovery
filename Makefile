PATTERN_PLAYGROUND_DIR=../discovery-examples/trace-pattern-finder/PatternPlayGround
TRACER_DIR= $(PATTERN_PLAYGROUND_DIR)/Tracer/DataFlowSanitizer/Automated
MINIZINC_FINDER_DIR= $(PATTERN_PLAYGROUND_DIR)/PatternFinder/MiniZinc

include $(TRACER_DIR)/Makefile

PROCESS_TRACE= $(TRACER_DIR)/process-trace.py
MINIZINC_FLAGS = -a --solver chuffed

TRACE_MAX_THREADS= 4

all-loop-trace: freqmine.loop1.trace freqmine.loop2.trace freqmine.loop3.trace	\
                freqmine.loop4.trace freqmine.loop5.trace freqmine.loop6.trace	\
                freqmine.loop7.trace

all-loop-simple-trace: freqmine.loop1.simple.trace freqmine.loop2.simple.trace	\
                       freqmine.loop3.simple.trace freqmine.loop4.simple.trace	\
                       freqmine.loop5.simple.trace freqmine.loop6.simple.trace	\
                       freqmine.loop7.simple.trace

# FIXME: condense! (but make pattern matching does not work as the target gets
# confused with other .loop%.trace targets).

# Iterations: 4
.NOTPARALLEL:
freqmine.loop1.trace: pkgs/apps/freqmine/src/*
	TRACE_REGION=1 TRACE_MAX_THREADS=$(TRACE_MAX_THREADS) ./build-trace.sh
	mv freqmine.trace $@

# Iterations: 1 (depends on size of input file)
.NOTPARALLEL:
freqmine.loop2.trace: pkgs/apps/freqmine/src/*
	TRACE_REGION=2 TRACE_MAX_THREADS=$(TRACE_MAX_THREADS) ./build-trace.sh
	mv freqmine.trace $@

# Iterations: 4
.NOTPARALLEL:
freqmine.loop3.trace: pkgs/apps/freqmine/src/*
	TRACE_REGION=3 TRACE_MAX_THREADS=$(TRACE_MAX_THREADS) ./build-trace.sh
	mv freqmine.trace $@

# Iterations: 4
.NOTPARALLEL:
freqmine.loop4.trace: pkgs/apps/freqmine/src/*
	TRACE_REGION=4 TRACE_MAX_THREADS=$(TRACE_MAX_THREADS) ./build-trace.sh
	mv freqmine.trace $@

# Iterations: 4
.NOTPARALLEL:
freqmine.loop5.trace: pkgs/apps/freqmine/src/*
	TRACE_REGION=5 TRACE_MAX_THREADS=$(TRACE_MAX_THREADS) ./build-trace.sh
	mv freqmine.trace $@

# Iterations: 4
.NOTPARALLEL:
freqmine.loop6.trace: pkgs/apps/freqmine/src/*
	TRACE_REGION=6 TRACE_MAX_THREADS=$(TRACE_MAX_THREADS) ./build-trace.sh
	mv freqmine.trace $@

# Iterations: 32
# Runs: 3
# This is the only loop that is run more than once, but only
# the last run is non-empty and thus traced.
.NOTPARALLEL:
freqmine.loop7.trace: pkgs/apps/freqmine/src/*
	TRACE_REGION=7 TRACE_MAX_THREADS=$(TRACE_MAX_THREADS) ./build-trace.sh
	mv freqmine.trace $@

freqmine.loop%.collapsed.trace: freqmine.loop%.simple.trace
	$(PROCESS_TRACE) transform --collapse-instances $*:loop-body $< > $@
