# Snyk pre-commit hooks

<!-- markdownlint-disable-next-line MD013 -->
![Functional Tests](https://github.com/fabasoad/pre-commit-snyk/workflows/Functional%20Tests/badge.svg) [![pre-commit.ci status](https://results.pre-commit.ci/badge/github/fabasoad/pre-commit-snyk/main.svg)](https://results.pre-commit.ci/latest/github/fabasoad/pre-commit-snyk/main) [![GitGuardian](https://img.shields.io/badge/gitguardian-passed-brightgreen)](https://github.com/fabasoad/pre-commit-snyk)

1. [snyk-container](#snyk-container)
2. [snyk-iac](#snyk-iac)
3. [snyk-test](#snyk-test)

## Description

Take into account that in case `snyk` is not installed locally it will be
automatically installed by `npm` **globally**.

To use any of these hooks **one of the following dependencies** have to be
installed: [snyk](https://docs.snyk.io/snyk-cli/install-the-snyk-cli), [yarn](https://yarnpkg.com/cli/install)
or [npm](https://nodejs.org/en/download/).

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
