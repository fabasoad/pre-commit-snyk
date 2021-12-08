# Snyk pre-commit hooks

1. [snyk-container](#snyk-container)
2. [snyk-iac](#snyk-iac)
3. [snyk-test](#snyk-test)

## Documentation

<!-- markdownlint-disable-next-line MD013 -->
> `<rev>` is the latest revision tag from [fabasoad/pre-commit-snyk](https://github.com/fabasoad/pre-commit-snyk/releases)
> repo.

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
