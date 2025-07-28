FROM node:20

ENV NODE_ENV="development"
ENV WDS_SOCKET_PORT=0

# Arguments
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

WORKDIR /app/apollo-client

# Copy only package files first to optimize Docker cache
COPY app/apollo-client/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the React app
COPY app/apollo-client .

# Build the React app
RUN npm run build

EXPOSE 3001
CMD ["npm", "start"]
