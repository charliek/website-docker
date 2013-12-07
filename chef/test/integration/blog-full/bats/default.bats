#!/usr/bin/env bats

@test "blog_service should be running in docker" {
	run sudo docker ps
	[[ "$output" == *"charliek/blog-service:latest"* ]]
}

@test "blog_service service responding" {
	run curl -I http://localhost:5679/ping
	[ "$status" -eq 0 ]
	[[ "$output" == *"HTTP/1.1 200 OK"* ]]
}

@test "grails_blog should be running in docker" {
	run sudo docker ps
	[[ "$output" == *"charliek/grails-blog:latest"* ]]
}

@test "grails_blog service responding" {
	run curl -I http://localhost:8080
	[ "$status" -eq 0 ]
	[[ "$output" == *"HTTP/1.1 200 OK"* ]]
}
