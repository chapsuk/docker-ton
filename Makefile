LITE_CLIENT_IMAGE=chapsuk/ton-lite-client
LITE_CLIENT_VERSION?=0.1.1
LITE_DOCKERFILE=lite-client/Dockerfile
LITE_BUILD_CONTEXT=lite-client/

.PHONY: lite_release lite_build lite_tag lite_push
lite_release: DOCKERFILE=${LITE_DOCKERFILE}
lite_release: IMAGE=${LITE_CLIENT_IMAGE}
lite_release: VERSION=${LITE_CLIENT_VERSION}
lite_release: BUILD_CONTEXT=${LITE_BUILD_CONTEXT}
lite_release: release
lite_build: DOCKERFILE=${LITE_DOCKERFILE}
lite_build: IMAGE=${LITE_CLIENT_IMAGE}
lite_build: VERSION=${LITE_CLIENT_VERSION}
lite_build: BUILD_CONTEXT=${LITE_BUILD_CONTEXT}
lite_build: build
lite_tag: IMAGE=${LITE_CLIENT_IMAGE}
lite_tag: VERSION=${LITE_CLIENT_VERSION}
lite_tag: tag
lite_push: IMAGE=${LITE_CLIENT_IMAGE}
lite_push: VERSION=${LITE_CLIENT_VERSION}
lite_push: push

.PHONY: release build tag push
release: build tag push

build:
	docker build -f ${DOCKERFILE} -t ${IMAGE}:${VERSION} ${BUILD_CONTEXT}

tag:
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

push:
	docker push ${IMAGE}:${VERSION}
	docker push ${IMAGE}:latest

