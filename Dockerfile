# Use MongoDB as the base image
FROM mongo:latest

# Install dependencies for Mongo-Express
RUN apt-get update && apt-get install -y git nodejs npm

# Clone Mongo-Express repo
RUN git clone https://github.com/mongo-express/mongo-express.git /mongo-express

# Install Mongo-Express
WORKDIR /mongo-express
RUN npm install

# Copy load_data script into the image
COPY load_data.sh /load_data.sh
RUN chmod +x /load_data.sh

# Copy JSON files into the image
COPY ./your_json_folder/*.json /your_json_folder/

# Run the load_data script
RUN /load_data.sh

# Copy custom entry script to start MongoDB and Mongo-Express
COPY start_services.sh /start_services.sh
RUN chmod +x /start_services.sh

# Set entry point
ENTRYPOINT ["/start_services.sh"]
