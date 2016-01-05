#!/bin/sh

docker run -v $(pwd):$(pwd) -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker --workdir=$(pwd) -ti --rm serverspec rspec -f html -o test.html test_spec.rb
