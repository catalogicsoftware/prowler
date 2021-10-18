CHECKS_ALL=$(subst check_,,$(filter-out check_sample,$(notdir $(wildcard checks/check*))))
TARGS=$(addprefix multiout/,$(addsuffix .json,$(CHECKS_ALL)))

OPTS=-M json
REGION=us-east-1

all: $(TARGS)

multiout/%.json:
	mkdir -p multiout/$*/
	-/usr/bin/time ./prowler -o multiout/$*  -c $* -f $(REGION) $(OPTS) 1>multiout/$*/prowler.out 2>multiout/$*/prowler.err
	cp multiout/$*/*.json $@

clean:
	rm -rf multiout 
