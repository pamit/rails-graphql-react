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
docker build -f Dockerfile.api -t my-blog-api .
docker run -p 3000:3000 --name my-blog-api my-blog-api

docker build -f Dockerfile.app -t my-blog-app .
docker run -p 3001:3001 --name my-blog-app my-blog-app
```

## Push to ECR

```shell
docker tag my-blog-api:latest public.ecr.aws/y6a1b9z5/my-blog-api:latest
docker tag my-blog-app:latest public.ecr.aws/y6a1b9z5/my-blog-app:latest

aws ecr-public get-login-password --region us-east-1 --profile pamit | docker login --username AWS --password-stdin public.ecr.aws/y6a1b9z5

docker push public.ecr.aws/y6a1b9z5/my-blog-api:latest
docker push public.ecr.aws/y6a1b9z5/my-blog-app:latest
```

## With Terraform

```shell
AWS_PROFILE=pamit terraform init
AWS_PROFILE=pamit terraform plan
AWS_PROFILE=pamit terraform apply
```
