# Snyk pre-commit hooks

1. [snyk-container](#snyk-container)
2. [snyk-iac](#snyk-iac)
3. [snyk-test](#snyk-test)

## Description

Take into account that in case `snyk` is not installed locally it will be
automatically installed by `npm` **globally**.

To use any of these hooks there are some additional dependencies are required
to be installed:

- Either [snyk](https://docs.snyk.io/snyk-cli/install-the-snyk-cli) or [npm](https://nodejs.org/en/download/)

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
