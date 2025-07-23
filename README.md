# README

```shell
foreman start -P Procfile.dev
```

Visit `http://localhost:3000/graphiql` for the GraphiQL interface.

Visit `http://localhost:3001/` for the main application.

# Deployment

## Build Docker Image

```shell
docker-compose -f docker-compose.yml up --build

# or
docker build -f Dockerfile.api.dev -t rails-blog-api-dev .
docker run -p 3000:3000 --name rails-blog-api-dev rails-blog-api-dev

docker build -f Dockerfile.app.dev -t rails-blog-app-dev .
docker run -p 3001:3001 --name rails-blog-app-dev rails-blog-app-dev
```

## Push to ECR

```shell
docker tag rails-blog-api-dev:latest public.ecr.aws/y6a1b9z5/pamit/rails-blog-api-dev:latest

aws ecr-public get-login-password --region us-east-1 --profile pamit | docker login --username AWS --password-stdin public.ecr.aws/y6a1b9z5

docker push public.ecr.aws/y6a1b9z5/pamit/rails-blog-api-dev:latest
```

