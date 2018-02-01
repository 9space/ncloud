# <img src="http://git.9space.io/open-source/nine-cloud/raw/master/lib/9space-spark.png" alt="spark" width="200" height="200">

The `ncloud` program is an interactive shell to manage the release and deployment on the Nine Cloud Platform. From within `ncloud` you can
issue any bash command, even using your local aliases and configuration, in addition to our packaged tools to simplify and automate processes.

For a quick introduction to `ncloud`, watch [our video on ...][].


[![Build Status](https://travis-ci.org/9space/nine-cloud.png?branch=master)](https://travis-ci.org/9space/nine-cloud)
[![Code Climate](https://codeclimate.com/github/9space/nine-cloud.png)](https://codeclimate.com/github/9space/nine-cloud)

[our video on Upcase]: https://upcase.com/videos/9space?utm_source=github&utm_medium=open-source&utm_campaign=9space

## Introduction

Our Nine Cloud Platform has been carefully pieced together with the most popular tools and robust architectual design to provide a continuous integration and scalable platform for your applications and servers. The platforms of choice are:
  1. Amazon AWS Cloud-Computing Services
  2. Kubernetes - Production-Grade Container Orchestration
  3. Docker - Software Container
  4. Gitlab - Git repository management

Our goal is to help developers and DevOps focus on what matters the most: Creating value for business and customers; not the day-to-day administrative and operational heartaches that come with software development and release process.

The `ncloud` program and the automated process to automate the entire release process enables you to achieve this goal.


## Why should you use ncloud?

* Coding, releasing and deploying tend to require different systems and tools. Avoid typing `aws` and `git` and `docker` and `kube-aws` over and over and over
  by running them in a dedicated shell.

Before:

        bash% ⏎
        docker build -t app:tag .
        docker push private-repository/app:tag

        bash% ⏎
        # Edit Kubernetes service configuration files
        edit app-service.yaml
        # Set Port and Docker Repos for Kubernetes deployment config files
        edit app-deployment.yaml

        bash% ⏎
        # Locate the kuberconfig file and load app onto the Kubernetes AWS cluster
        kuberctl --kuberconfig /some/dir/with/my/kuberconfig create -f app-service.yaml

        bash% ⏎
        # Monitor rollout status of deployment and pods
        kuberctl --kuberconfig /some/dir/with/my/kuberconfig rollout status deployment/app
        kuberctl --kuberconfig /some/dir/with/my/kuberconfig describe deployment/app

        # and before and after you may have to do...
        aws ec2 create-repository --repository-name private-repository ...
        git commit ...
        git push ...
        git tag ...
        ssh myserver ...

Now:

<pre><code>sh$ ncloud
ncloud $ git commit -m "Ship it!"
ncloud $ release install # generate the Kubernetes YAML file based
ncloud $ release push # replaces docker commands
ncloud $ shell kubectl
ncloud-shell:kubectl $ kc rollout dep/app
ncloud-shell:kubectl $ kc dep/app
ncloud-shell:kubectl $ kc pods/app
</code></pre>

* The above gives you the power to control the workflow. Using our continuous integration (CI) setup the above would be as simple as:

<pre><code>sh$ ncloud
ncloud $ git checkout "deploy/prod"
ncloud $ git commit -m "Ship it!" && git push
ncloud $ shell kubectl
ncloud-shell:kubectl $ kc status dep/prod/app
</code></pre>

## Installing ncloud

* Mac OS X, via homebrew:

See the [installation guide][INSTALL] for install instructions for other
operating systems.

## Contributing to ncloud

Pull requests are very welcome. See the [contributing guide][CONTRIBUTING] for
more details.

## Versions

```
{{VERSION}}
```

#### Compatibility Matrix

| ncloud version | k8s 1.4.x | k8s 1.6.x | k8s 1.7.x | k8s 1.8.x |
|--------------|-----------|-----------|-----------|-----------|
| 1.0.x        | Y         | N         | N         | N         |
| 2.0.x        | N         | N         | N         | Y         |

## Similar projects

[Tectonic][https://github.com/coreos/tectonic-installer]

## License

NineCloud or ncloud or 9cloud is copyright © 2018 9Space Pty Ltd (http://www.9space.io). Terms specified in the
[LICENSE][LICENSE] file.

## About 9space

# <img src="http://git.9space.io/open-source/nine-cloud/raw/master/lib/9space-logo.png" alt="spark" width="200" height="60">

## Versions
alpine:3.7
NODE_VERSION=8.9.3 NPM_VERSION=5.5.1
PLATFORM linux-amd64
KUBECTL_VERSION v1.8.4
KUBE_AWS_VERSION 0.9.9
HELM_VERSION v2.7.2
DOCKER_VERSION 1.13.1
