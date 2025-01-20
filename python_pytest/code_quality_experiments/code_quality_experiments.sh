#!/bin/bash

function ruff_based_code_quality() {
  pipenv run ruff check "$1" --config code_quality_experiments/supermarketreceipt-refactoring-kata.toml
}

function cyclomatic_complexity() {
  pipenv run radon cc -a -j src > "$1"
}

function halstead_complexity() {
  pipenv run radon hal -j src > "$1"
}

function mi_complexity() {
  pipenv run radon mi -j src > "$1"
}

date="$(date "+%Y-%m-%d-%H%M")"
cyclomatic_complexity code_quality_experiments/radon-feedback/mccabe/radon-cc-feedback-"$date".json

halstead_complexity code_quality_experiments/radon-feedback/halstead/radon-halstead-feedback-"$date".json

mi_complexity code_quality_experiments/radon-feedback/mi/radon-mi-feedback-"$date".json