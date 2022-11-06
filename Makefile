# REBAR_GIT_CLONE_OPTIONS += --depth 1
# export REBAR_GIT_CLONE_OPTIONS

# .PHONY: default all build clean compile release shell


# REBAR = rebar3

# default: compile
# all: clean compile test
# compile:
# 	@$(rebar) compile
# clean:
# 	@$(rebar) clean
# cleanall:
# 	@$(rebar) clean -a
# test:
# 	@$(rebar) do ct
# shell:
# 	@$(rebar) shell
# upgrade:
# 	@$(rebar) upgrade --all
# release:
# 	@$(rebar) release
# cover:
# 	$(REBAR) cover
# tar:
# 	@$(rebar) as prod tar

# distclean:
# 	@rm -rf _build
# 	@rm -f data/app.*.config data/vm.*.args rebar.lock

## shallow clone for speed

REBAR_GIT_CLONE_OPTIONS += --depth 1
export REBAR_GIT_CLONE_OPTIONS

REBAR = rebar3
all: compile

compile:
	$(REBAR) compile

ct: compile
	$(REBAR) as test ct -v

eunit: compile
	$(REBAR) as test eunit

xref:
	$(REBAR) xref

cover:
	$(REBAR) cover

clean: distclean

distclean:
	@rm -rf _build
	@rm -f data/app.*.config data/vm.*.args rebar.lock

CUTTLEFISH_SCRIPT = _build/default/lib/cuttlefish/cuttlefish

$(CUTTLEFISH_SCRIPT):
	@${REBAR} get-deps
	@if [ ! -f cuttlefish ]; then make -C _build/default/lib/cuttlefish; fi

app.config: $(CUTTLEFISH_SCRIPT) etc/myip.config
	$(verbose) $(CUTTLEFISH_SCRIPT) -l info -e etc/ -c etc/myip.config -i priv/myip.schema
