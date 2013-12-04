@test "blog service should be running" {
	run service blogapp status
	[[ "$output" == *"start/running"* ]]
}

@test "blog service service responding" {
	run curl -I http://localhost:5678
	[ "$status" -eq 0 ]
	[[ "$output" == *"HTTP/1.1 200 OK"* ]]
}

@test "grails application should be running" {
	run service blogapp status
	[[ "$output" == *"start/running"* ]]
}

@test "grails application service responding" {
	run curl -I http://localhost:8080
	[ "$status" -eq 0 ]
	[[ "$output" == *"HTTP/1.1 200 OK"* ]]
}
