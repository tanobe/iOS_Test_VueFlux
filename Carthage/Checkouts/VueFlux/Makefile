gems-install:
	bundle install --path vendor/bundle

lib-lint:
	bundle exec pod lib lint

pod-release:
	bundle exec pod trunk push VueFlux.podspec
	bundle exec pod trunk push VueFluxReactive.podspec
