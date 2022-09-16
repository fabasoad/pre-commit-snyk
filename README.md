# Snyk pre-commit hooks

<!-- markdownlint-disable-next-line MD013 -->
![GitHub release](https://img.shields.io/github/v/release/fabasoad/pre-commit-snyk?include_prereleases) ![Functional Tests](https://github.com/fabasoad/pre-commit-snyk/workflows/Functional%20Tests/badge.svg) [![pre-commit.ci status](https://results.pre-commit.ci/badge/github/fabasoad/pre-commit-snyk/main.svg)](https://results.pre-commit.ci/latest/github/fabasoad/pre-commit-snyk/main) [![BCH compliance](https://bettercodehub.com/edge/badge/fabasoad/pre-commit-snyk?branch=main)](https://bettercodehub.com/)

1. [snyk-container](#snyk-container)
2. [snyk-iac](#snyk-iac)
3. [snyk-test](#snyk-test)

## Description

Take into account that in case `snyk` is not installed locally it will be
automatically installed **globally**.

To use any of these hooks **one of the following tools** have to be installed:
[snyk](https://docs.snyk.io/snyk-cli/install-the-snyk-cli), [yarn](https://yarnpkg.com/cli/install),
[npm](https://nodejs.org/en/download/), [brew](https://brew.sh/) or [scoop](https://scoop.sh/).

## Documentation

<!-- markdownlint-disable-next-line MD013 -->
> `<rev>` in the examples below, is the latest revision tag from [fabasoad/pre-commit-snyk](https://github.com/fabasoad/pre-commit-snyk/releases)
> repository.

### snyk-container

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-snyk
    rev: <rev>
    hooks:
      - id: snyk-container
        args: ["--exclude-base-image-vulns"]
```

> `args` is optional. In this example you can skip base image vulnerabilities.

### snyk-iac

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-snyk
    rev: <rev>
    hooks:
      - id: snyk-iac
        args:
          - <folder>
```

Where:

- `<folder>` is the folder path that you want to test.

### snyk-test

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-snyk
    rev: <rev>
    hooks:
      - id: snyk-test
```
