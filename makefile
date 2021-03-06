bootstrap:
	@echo "\033[94m• Setting up go test for wasm to run in the browser\033[00m"
	go get -u github.com/agnivade/wasmbrowsertest
	mv ${GOPATH}/bin/wasmbrowsertest ${GOPATH}/bin/go_js_wasm_exec

test:
	@echo "\033[94m• Running Go vet\033[00m"
	go vet ./...
	@echo "\033[94m\n• Running Go tests\033[00m"
	go test -race ./...
	@echo "\033[94m\n• Running go wasm tests\033[00m"
	GOARCH=wasm GOOS=js go test ./pkg/app

release: test
ifdef VERSION
	@echo "\033[94m\n• Releasing ${VERSION}\033[00m"
	@git checkout v6
	@git tag ${VERSION}
	@git push origin ${VERSION}

else
	@echo "\033[94m\n• Releasing version\033[00m"
	@echo "\033[91mVERSION is not defided\033[00m"
	@echo "~> make VERSION=\033[90mv6.0.0\033[00m release"
endif
	

clean:
	@go clean -v ./...
