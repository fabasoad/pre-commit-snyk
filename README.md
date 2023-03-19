# Snyk pre-commit hooks

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![GitHub release](https://img.shields.io/github/v/release/fabasoad/pre-commit-snyk?include_prereleases)
![Functional Tests](https://github.com/fabasoad/pre-commit-snyk/workflows/Functional%20Tests/badge.svg)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/fabasoad/pre-commit-snyk/main.svg)](https://results.pre-commit.ci/latest/github/fabasoad/pre-commit-snyk/main)

1. [snyk-container](#snyk-container)
2. [snyk-iac](#snyk-iac)
3. [snyk-test](#snyk-test)

## Description

Take into account that in case `snyk` is not installed locally it will be
automatically installed **globally**. Here is the order of the attempts for
this tool to install `snyk`:

- [brew](https://brew.sh/), hence it should be installed.
- [scoop](https://scoop.sh/), hence it should be installed.
- [npm](https://nodejs.org/en/download/), hence it should be installed.
- [yarn](https://yarnpkg.com/cli/install), hence it should be installed.
- Standalone installation, for this [curl](https://curl.se/) has to be installed.

If none of the tools above are installed then installation process will fail.

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
