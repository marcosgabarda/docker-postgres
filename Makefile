# Variables
# ------------------------------------------------------------------------------
POSTGRES_IMAGE_ID := marcosgabarda/postgres
POSTGIS_IMAGE_ID := marcosgabarda/postgis

# Versions to build
# ------------------------------------------------------------------------------
POSTGRES_VERSIONS := 10 11 12 13 14 15
POSTGRES_LATEST_VERSION := 16
POSTGIS_VERSIONS := 11-2.5 12-3.0 13-3.1 14-3.4 15-3.4
POSTGIS_LATEST_VERSION := 16-3.4

.PHONY: build_postgres push_postgres build_postgis push_postgis build push

build_postgres:
	@for version in $(POSTGRES_VERSIONS) ; do \
		docker buildx build . -f ./postgres/$$version/Dockerfile --tag ${POSTGRES_IMAGE_ID}:$$version --platform linux/amd64,linux/arm64 ; \
	done
	docker buildx build . -f ./postgres/${POSTGRES_LATEST_VERSION}/Dockerfile --tag ${POSTGRES_IMAGE_ID}:${POSTGRES_LATEST_VERSION} --tag ${POSTGRES_IMAGE_ID}:latest --platform linux/amd64,linux/arm64

push_postgres:
	@for version in $(POSTGRES_VERSIONS) ; do \
		docker buildx build . -f ./postgres/$$version/Dockerfile --tag ${POSTGRES_IMAGE_ID}:$$version --platform linux/amd64,linux/arm64 --push ; \
	done
	docker buildx build . -f ./postgres/${POSTGRES_LATEST_VERSION}/Dockerfile --tag ${POSTGRES_IMAGE_ID}:${POSTGRES_LATEST_VERSION} --tag ${POSTGRES_IMAGE_ID}:latest --platform linux/amd64,linux/arm64 --push

build_postgis:
	@for version in $(POSTGIS_VERSIONS) ; do \
		docker buildx build . -f ./postgis/$$version/Dockerfile --tag ${POSTGIS_IMAGE_ID}:$$version --tag ${POSTGIS_IMAGE_ID}:$(word 1, $(subst -, ,$$version)) --platform linux/amd64,linux/arm64 ; \
	done
	docker buildx build . -f ./postgis/${POSTGIS_LATEST_VERSION}/Dockerfile --tag ${POSTGIS_IMAGE_ID}:${POSTGIS_LATEST_VERSION} --tag ${POSTGIS_IMAGE_ID}:$(word 1, $(subst -, ,$(POSTGIS_LATEST_VERSION))) --tag ${POSTGIS_IMAGE_ID}:latest --platform linux/amd64,linux/arm64

push_postgis:
	@for version in $(POSTGIS_VERSIONS) ; do \
		docker buildx build . -f ./postgis/$$version/Dockerfile --tag ${POSTGIS_IMAGE_ID}:$$version --tag ${POSTGIS_IMAGE_ID}:$(word 1, $(subst -, ,$$version)) --platform linux/amd64,linux/arm64 --push ; \
	done
	docker buildx build . -f ./postgis/${POSTGIS_LATEST_VERSION}/Dockerfile --tag ${POSTGIS_IMAGE_ID}:${POSTGIS_LATEST_VERSION} --tag ${POSTGIS_IMAGE_ID}:14 --tag ${POSTGIS_IMAGE_ID}:latest --platform linux/amd64,linux/arm64 --push

build: build_postgres build_postgis

push: push_postgres push_postgis
