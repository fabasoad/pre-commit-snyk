# Snyk pre-commit hooks

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![GitHub release](https://img.shields.io/github/v/release/fabasoad/pre-commit-snyk?include_prereleases)
![security](https://github.com/fabasoad/pre-commit-snyk/actions/workflows/security.yml/badge.svg)
![linting](https://github.com/fabasoad/pre-commit-snyk/actions/workflows/linting.yml/badge.svg)
![functional-tests](https://github.com/fabasoad/pre-commit-snyk/actions/workflows/functional-tests.yml/badge.svg)

## Table of Contents

- [How it works?](#how-it-works)
- [Prerequisites](#prerequisites)
- [Hooks](#hooks)
  - [snyk-code](#snyk-code)
  - [snyk-container](#snyk-container)
  - [snyk-iac](#snyk-iac)
  - [snyk-log4shell](#snyk-log4shell)
  - [snyk-test](#snyk-test)
- [Customization](#customization)
  - [Description](#description)
  - [Parameters](#parameters)
    - [Snyk](#snyk)
    - [pre-commit-snyk](#pre-commit-snyk)
      - [Log level](#log-level)
      - [Log color](#log-color)
      - [Snyk version](#snyk-version)
      - [Clean cache](#clean-cache)
  - [Examples](#examples)

## How it works?

At first hook tries to use globally installed `snyk` tool. And if it doesn't exist
then hook installs `snyk` into a `.fabasoad/pre-commit-snyk` temporary directory
that will be removed after scanning is completed.

## Prerequisites

The following tools have to be available on a runner prior using this pre-commit
hook:

- [bash >=4.0](https://www.gnu.org/software/bash/)
- [curl](https://curl.se/)

## Hooks

<!-- markdownlint-disable-next-line MD013 -->

> `<rev>` in the examples below, is the latest revision tag from [fabasoad/pre-commit-snyk](https://github.com/fabasoad/pre-commit-snyk/releases)
> repository.

### snyk-code

This hook runs [snyk code test](https://docs.snyk.io/snyk-cli/commands/code-test)
command.

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-snyk
    rev: <rev>
    hooks:
      - id: snyk-code
```

### snyk-container

This hook runs [snyk container test](https://docs.snyk.io/snyk-cli/commands/container-test)
command.

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-snyk
    rev: <rev>
    hooks:
      - id: snyk-container
```

### snyk-iac

This hook runs [snyk iac test](https://docs.snyk.io/snyk-cli/commands/iac-test)
command.

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-snyk
    rev: <rev>
    hooks:
      - id: snyk-iac
```

### snyk-log4shell

This hook runs [snyk log4shell](https://docs.snyk.io/snyk-cli/commands/log4shell)
command.

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-snyk
    rev: <rev>
    hooks:
      - id: snyk-log4shell
```

### snyk-test

This hook runs [snyk test](https://docs.snyk.io/snyk-cli/commands/test) command.

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-snyk
    rev: <rev>
    hooks:
      - id: snyk-test
```

## Customization

### Description

There are 2 ways to customize scanning for both `snyk` and `pre-commit-snyk` -
environment variables and arguments passed to [args](https://pre-commit.com/#config-args).

You can pass arguments to the hook as well as to the `snyk` itself. To distinguish
parameters you need to use `--snyk-args` for `snyk` arguments and `--hook-args`
for `pre-commit-snyk` arguments. Supported delimiter is `=`. So, use `--hook-args=<arg>`
but not `--hook-args <arg>`. Please find [Examples](#examples) for more details.

### Parameters

#### Snyk

You can install `snyk` locally and run `snyk --help` to see all the available
arguments:

<!-- markdownlint-disable MD013 -->

```shell
$ snyk --version
1.1291.1

$ snyk --help
CLI help
  Snyk CLI scans and monitors your projects for security vulnerabilities and license issues.

  For more information visit the Snyk website https://snyk.io

  For details see the CLI documentation https://docs.snyk.io/features/snyk-cli

How to get started
  1. Authenticate by running snyk auth.
  2. Test your local project with snyk test.
  3. Get alerted for new vulnerabilities with snyk monitor.

Available commands
  To learn more about each Snyk CLI command, use the --help option, for example, snyk auth
  --help.

  Note: The help on the docs site is the same as the --help in the CLI.

  snyk auth
    Authenticate Snyk CLI with a Snyk account.

  snyk test
    Test a project for open-source vulnerabilities and license issues.

    Note: Use snyk test --unmanaged to scan all files for known open-source dependencies (C/C++
    only).

  snyk monitor
    Snapshot and continuously monitor a project for open-source vulnerabilities and license
    issues.

  snyk container
    These commands test and continuously monitor container images for vulnerabilities and
    generate an SBOM for a container image.

  snyk iac
    These commands find and report security issues in Infrastructure as Code files; detect,
    track, and alert on infrastructure drift and unmanaged resources; and create a .driftigore
    file.

  snyk code
    The snyk code test command finds security issues using Static Code Analysis.

  snyk sbom
    Generate or test an SBOM document in ecosystems supported by Snyk.

  snyk log4shell
    Find Log4Shell vulnerability.

  snyk config
    Manage Snyk CLI configuration.

  snyk policy
    Display the .snyk policy for a package.

  snyk ignore
    Modify the .snyk policy to ignore stated issues.

Debug
  Use -d option to output the debug logs.

Configure the Snyk CLI
  You can use environment variables to configure the Snyk CLI and also set variables to
  configure the Snyk CLI to connect with the Snyk API. See Configure the Snyk CLI
  https://docs.snyk.io/features/snyk-cli/configure-the-snyk-cli
```

<!-- markdownlint-enable MD013 -->

#### pre-commit-snyk

Here is the precedence order of `pre-commit-snyk` tool:

- Parameter passed to the hook as argument via `--hook-args`.
- Environment variable.
- Default value.

For example, if you set `PRE_COMMIT_SNYK_LOG_LEVEL=warning` and `--hook-args=--log-level
error` then `error` value will be used.

##### Log level

With this parameter you can control the log level of `pre-commit-snyk` hook output.
It doesn't impact `snyk` log level output. To control `snyk` log level output
please look at the [Snyk parameters](#snyk).

- Parameter name: `--log-level`
- Environment variable: `PRE_COMMIT_SNYK_LOG_LEVEL`
- Possible values: `debug`, `info`, `warning`, `error`
- Default: `info`

##### Log color

With this parameter you can enable/disable the coloring of `pre-commit-snyk`
hook logs. It doesn't impact `snyk` logs coloring.

- Parameter name: `--log-color`
- Environment variable: `PRE_COMMIT_SNYK_LOG_COLOR`
- Possible values: `true`, `false`
- Default: `true`

##### Snyk version

Specifies specific `snyk` version to use. This will work only if `snyk` is not
globally installed, otherwise globally installed `snyk` takes precedence.

- Parameter name: `--snyk-version`
- Environment variable: `PRE_COMMIT_SNYK_SNYK_VERSION`
- Possible values: Snyk version that you can find [here](https://github.com/snyk/cli/releases)
- Default: `latest`

##### Clean cache

With this parameter you can choose either to keep cache directory (`.fabasoad/pre-commit-snyk`),
or to remove it. By default, it removes cache directory. With `false` parameter
cache directory will not be removed which means that if `snyk` is not installed
globally every subsequent run won't download `snyk` again. Don't forget to add
cache directory into the `.gitignore` file.

- Parameter name: `--clean-cache`
- Environment variable: `PRE_COMMIT_SNYK_CLEAN_CACHE`
- Possible values: `true`, `false`
- Default: `true`

### Examples

Pass arguments separately from each other:

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-snyk
    rev: <rev>
    hooks:
      - id: snyk-test
        args:
          - --hook-args=--log-level debug
          - --snyk-args=--package-manager=pip
          - --snyk-args=--file=requirements.txt
```

Pass arguments altogether grouped by category:

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-snyk
    rev: <rev>
    hooks:
      - id: snyk-iac
        args:
          - --hook-args=--log-level debug
          - --snyk-args=--detection-depth=1 --ignore-policy
```
