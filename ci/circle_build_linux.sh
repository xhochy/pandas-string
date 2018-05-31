#!/bin/bash

set -eo pipefail

export CONDA_PKGS_DIRS=$HOME/.conda_packages
export MINICONDA=$HOME/miniconda
export MINICONDA_URL="https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"
export PATH="$MINICONDA/bin:$PATH"

wget --no-verbose -O miniconda.sh $MINICONDA_URL
bash miniconda.sh -b -p $MINICONDA
export PATH="$MINICONDA/bin:$PATH"

conda update -y -q conda
conda config --set auto_update_conda false
conda config --add channels https://repo.continuum.io/pkgs/free
conda config --add channels conda-forge

conda create -y -q -n fletcher python=3.6 \
    pandas pyarrow pytest pytest-cov \
    flake8 \
    pip \
    numba \
    -c conda-forge

source activate fletcher
pip install -e .
py.test --junitxml=test-reports/junit.xml
