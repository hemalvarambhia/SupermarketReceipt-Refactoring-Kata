#!/bin/bash

function ruff_based_code_quality() {
  pipenv run ruff check "$1" --config code_quality_experiments/supermarketreceipt-refactoring-kata.toml
}