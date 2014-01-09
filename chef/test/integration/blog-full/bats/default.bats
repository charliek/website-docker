#!/usr/bin/env bats

@test "open jdk 7 is installed" {
	run /usr/bin/java -version
	[[ "$output" == *"OpenJDK Runtime Environment"* ]]
	[[ "$output" == *"1.7.0"* ]]
}

@test "grails-blog upstart should be in place" {
	run cat /etc/init/grails-blog.conf
    [[ "$output" == *"/opt/jetty-runner/jetty-runner-9.1.0.jar"* ]]
}

@test "blog-service upstart should be in place" {
	run cat /etc/init/blog-service.conf
	[[ "$output" == *"/opt/blog-service/blog-service-"* ]]
}

