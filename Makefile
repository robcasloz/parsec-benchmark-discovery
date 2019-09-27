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

all-loop-maps-pdf: freqmine.loop1.maps.pdf freqmine.loop3.maps.pdf	\
                   freqmine.loop4.maps.pdf freqmine.loop5.maps.pdf	\
                   freqmine.loop7.maps.pdf

freqmine.trace: pkgs/apps/freqmine/src/*
	TRACE_MAX_THREADS=$(TRACE_MAX_THREADS) ./build-trace.sh freqmine

# Iterations: 4
freqmine.loop1.trace: freqmine.simple.trace
	$(PROCESS_TRACE) transform --filter-marks 1 $< > $@

# Iterations: 1
# The number of iterations depends on size of input file.
freqmine.loop2.trace: freqmine.simple.trace
	$(PROCESS_TRACE) transform --filter-marks 2 $< > $@

# Iterations: 4
freqmine.loop3.trace: freqmine.simple.trace
	$(PROCESS_TRACE) transform --filter-marks 3 $< > $@

# Iterations: 4
freqmine.loop4.trace: freqmine.simple.trace
	$(PROCESS_TRACE) transform --filter-marks 4 $< > $@

# Iterations: 4
freqmine.loop5.trace: freqmine.simple.trace
	$(PROCESS_TRACE) transform --filter-marks 5 $< > $@

# Iterations: 4
# This loop does not perform any data transformation, it only initializes an
# array that is not used lated on. Thus, it is simplified away.
freqmine.loop6.trace: freqmine.simple.trace
	$(PROCESS_TRACE) transform --filter-marks 6 $< > $@

# Iterations: 32
# Runs: 3
# This is the only loop that is run more than once, but only
# the last run is non-empty and thus traced.
freqmine.loop7.trace: freqmine.simple.trace
	$(PROCESS_TRACE) transform --filter-marks 7 $< > $@
