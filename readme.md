## Terraform web application project for AWS

#### State:
- S3 backend.

#### VPC:
- Two public subnets: `eu_central_1a`, `eu_central_1b`.

#### Database:
- RDS `db.t2.micro` database instance, `multi_az` disabled.

#### Queues:
- SQS queue with SNS bus.

#### Autoscaling:
- Launch configuration keeps single `t2.small` EC2 instance.
- Load balancer is configured for `eu_central_1a`, `eu_central_1b` subnets.

#### Deployments:
- Codedeploy that deploys BE application.
