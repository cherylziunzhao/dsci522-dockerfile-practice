FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Install mamba
RUN conda install -c conda-forge mamba -y \
    && mamba clean --all -y -f

# Copy the conda lock file
COPY conda-linux-64.lock /tmp/conda-linux-64.lock

# Install packages using mamba
RUN mamba update --quiet --file /tmp/conda-linux-64.lock \
    && mamba clean --all -y -f \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"
