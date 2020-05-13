#!/bin/bash
set -e
set -u
set -o pipefail
// TODO more flexible!
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"