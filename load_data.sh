    #!/bin/bash

# Initialize a variable to keep track of MongoDB's state
mongo_ready=0

# Start MongoDB as a background process
mongod &

# Loop until MongoDB is ready
while [[ mongo_ready -eq 0 ]]; do
    echo "Checking MongoDB..."
    
    # Execute a simple command on MongoDB, redirecting all output to /dev/null
    mongo --eval "db.adminCommand('ping')" > /dev/null 2>&1
    
    # Check the return code of the last command
    if [[ $? -eq 0 ]]; then
        echo "MongoDB is ready."
        mongo_ready=1
    else
        echo "MongoDB is not ready, waiting for 2 seconds before checking again."
        sleep 2
    fi
done

# Load JSON files into MongoDB
mongoimport --db your_database --collection your_collection --file /your_json_folder/your_file.json

# Clean up: Optionally shut down MongoDB
mongod --shutdown
