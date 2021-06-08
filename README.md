#### kraken ####

# Docker Image

Is built automatically and is available here:

[https://hub.docker.com/repository/docker/darron/kraken](https://hub.docker.com/repository/docker/darron/kraken)

NOTE: I switched to Alpine Linux to minimize the attack surface. I originally built it with Ubuntu, but:

1. The most current version of Ubuntu wouldn't build on Docker Hub for some reason.
2. The older version of Ubuntu had several medium severity Anchore security problems.

# Kubernetes StatefulSet

Tested on DigitalOcean:

```bash
~ kubectl apply -f kubernetes.yml
~ kubectl get pvc
NAME              STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS       AGE
data-litecoin-0   Bound    pvc-75c80746-1a78-44f0-8505-c57e93144574   1Gi        RWO            do-block-storage   16m
```

# All the Continuouses

1. Automatically building the Docker image using Docker Hub: [darron/kraken](https://hub.docker.com/repository/docker/darron/kraken)
2. [Automatically running Anchore](https://github.com/darron/kraken/blob/main/.github/workflows/anchore-analysis.yml) using Github Actions.
3. TODO: Travis deploy to Kubernetes.

# Terraform lovers unite.

To run it:

```bash
cd tf
terraform init
terraform apply
```

It works:

```bash
aws_iam_group.prod-ci-group: Creating...
aws_iam_user.prod-ci-user: Creating...
aws_iam_role.prod-ci-role: Creating...
aws_iam_group.prod-ci-group: Creation complete after 1s [id=prod-ci-group]
aws_iam_user.prod-ci-user: Creation complete after 1s [id=prod-ci-user]
aws_iam_group_membership.prod-ci: Creating...
aws_iam_role.prod-ci-role: Creation complete after 2s [id=prod-ci-role]
data.aws_iam_policy_document.prod-ci-group-policy: Reading...
data.aws_iam_policy_document.prod-ci-group-policy: Read complete after 0s [id=1192436697]
aws_iam_group_membership.prod-ci: Creation complete after 1s [id=prod-ci]
aws_iam_group_policy.prod-ci-group-policy: Creating...
aws_iam_group_policy.prod-ci-group-policy: Creation complete after 0s [id=prod-ci-group:prod-ci-group-policy]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
```