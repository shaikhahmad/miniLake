#!/bin/bash

echo "Starting jupyter notebook..."
jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --notebook-dir=/notebook