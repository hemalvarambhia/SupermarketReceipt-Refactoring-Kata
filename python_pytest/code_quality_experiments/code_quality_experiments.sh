#!/bin/bash

function ruff_based_code_quality() {
  # --output-format=json yields JSON format e.g.
  # pipenv run ruff check path/to/file --config path --output-format=json,pylint,junit,github
  pipenv run ruff check "$1" --config code_quality_experiments/supermarketreceipt-refactoring-kata.toml --output-format=pylint
}