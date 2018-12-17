test:
	head Sport-sessions/GPS-data/0562fe6b-084a-43e1-8b4b-50bf06a9141d.json | \
		sed 's/"latitude":[0-9.]*/"latitude":-1/g'| \
		sed 's/"longitude":[0-9.]*/"longitude":-1/g'
