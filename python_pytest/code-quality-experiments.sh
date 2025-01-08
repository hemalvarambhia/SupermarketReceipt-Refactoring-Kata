#!/bin/bash

function pylint_based_code_quality() {
  pipenv run pylint "$1"  --output-format=json
}

function ruff_based_code_quality() {
  pipenv run ruff check "$1" --config supermarketreceipt-refactoring.toml
}