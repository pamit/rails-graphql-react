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

Create public (free) repositories in ECR:
- `my-blog-api`
- `my-blog-app`

```shell
aws ecr-public get-login-password --region us-east-1 --profile pamit | docker login --username AWS --password-stdin public.ecr.aws/y6a1b9z5

docker tag my-blog-api:latest public.ecr.aws/y6a1b9z5/my-blog-api:latest
docker tag my-blog-app:latest public.ecr.aws/y6a1b9z5/my-blog-app:latest

docker push public.ecr.aws/y6a1b9z5/my-blog-api:latest
docker push public.ecr.aws/y6a1b9z5/my-blog-app:latest

# or buildx for multi-arch images
docker buildx build --platform linux/amd64,linux/arm64 \
  -t public.ecr.aws/y6a1b9z5/my-blog-api:latest \
  -f Dockerfile.api . \
  --push .

docker buildx build --platform linux/amd64,linux/arm64 \
    --build-arg REACT_APP_API_URL=http://my-blog-api-service:3000/graphql \
    -t public.ecr.aws/y6a1b9z5/my-blog-app:latest \
    -f Dockerfile.app \
    --push .
```

## With Terraform

```shell
AWS_PROFILE=pamit terraform init
AWS_PROFILE=pamit terraform plan
AWS_PROFILE=pamit terraform apply
```

## Notes

As we use ALBs for the Rails API and React app, we need to whitelist the ALB DNS names in the CORS configuration (`cors.rb`) of the Rails API.

Also, in development.rb we need to update `config.hosts` to include the ALB DNS names, e.g.:

```ruby
config.hosts << "rails-api-alb-567545412.ap-southeast-2.elb.amazonaws.com"
```
