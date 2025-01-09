#!/bin/bash

function pylint_based_code_quality() {
  pipenv run pylint "$1"
}