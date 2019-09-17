# Step 1:
# Build image and add a descriptive tag
docker build . -t mktavish/capstone-project:v1

# Step 2: 
# List docker images
docker image ls

# Step 3: 
# Run create-react-app
docker run -p 5000:80 mktavish/capstone-project

# Step 4:
# Login to dockerhub
docker login

# Step 5:
# Push image to dockerhub repository
docker push mktavish/capstone-project:v1
