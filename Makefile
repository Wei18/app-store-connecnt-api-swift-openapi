#!make

# Special-Targets #
# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
.DEFAULT_GOAL := install
OPENAPI_PATH  := OAS/openapi.json
SUBDIRS       := $(addprefix Sources/, AppStoreConnectAPIOAS)
SWIFT_FILES   := $(addsuffix /Client.swift, $(SUBDIRS))
.SECONDARY    : $(%.yml)

%/openapi-generator-config.yml:
	@mkdir -p "$(@D)"
	echo "generate:" > $@; \
	echo "  - types" >> $@; \
	echo "  - client" >> $@; \
	echo "" >> $@; \
	echo "accessModifier: public" >> $@; \
	echo "" >> $@;
	@git add $@
	@echo "::debug:: make $@"

%/Client.swift: %/openapi-generator-config.yml $(OPENAPI_PATH)
	mint run apple/swift-openapi-generator generate $(OPENAPI_PATH) \
		--config $(@D)/openapi-generator-config.yml \
		--output-directory $(@D)
	@git add $(@D)
	@git commit -m "[Make] Generate $(@D)/*.swift" >/dev/null \
	&& echo "::notice:: make $@" \
	|| true

.PHONY: install-$(OPENAPI_PATH)
install-$(OPENAPI_PATH):
ifdef GITHUB_ACTIONS ## https://docs.github.com/en/actions/learn-github-actions/variables
	@touch $(OPENAPI_PATH)
	@echo "::notice:: make $@"
else
	@zip_file="app-store-connect-openapi-specification.zip"; \
	download_url="https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip"; \
	curl -L -o "$$zip_file" "$$download_url"; \
	unzip "$$zip_file"; \
	rm "$$zip_file"; 

	@mv openapi.json $(OPENAPI_PATH)
	@git add $(OPENAPI_PATH)
	@git commit -m "[Make] Update app-store-connect-openapi-specification" >/dev/null \
	&& touch $(OPENAPI_PATH) \
	&& echo "::notice:: make $@" \
	|| true
endif

install: install-$(OPENAPI_PATH) $(SWIFT_FILES) 
	@echo "::notice:: make $@"

.PHONY: update-to-date
update-to-date:
	touch $(OPENAPI_PATH)
	touch Sources/**/openapi-generator-config.yml
	touch Sources/**/openapi.yml
	touch Sources/**/Client.swift

.PHONY: help
.SILENT: help
help:
	echo -----------------------------------------------------------------------
	awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	echo -----------------------------------------------------------------------
