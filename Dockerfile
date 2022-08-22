FROM jupyter/minimal-notebook
ENV CONDA_OVERRIDE_CUDA=11.6
USER root
# Needed for graphviz stuff to work
RUN apt-get -qq update --yes && apt-get install -yq --no-install-recommends build-essential && apt-get -qq install --yes graphviz curl ffmpeg libsm6 libxext6 && \
    apt-get -qq clean && rm -rf /var/lib/apt/lists/* && mkdir /content && chown jovyan:users /content
USER ${NB_UID}
RUN mamba install -yq -c conda-forge pip importlib_metadata filelock huggingface_hub numpy packaging pyyaml regex requests tqdm scipy pandas
RUN pip install diffusers==0.2.3 transformers

# TODO this isn't working fixme: default to Darkmode. Comment out if you don't want this 
COPY overrides.json /opt/conda/share/jupyter/lab/settings/

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start.sh", "jupyter", "notebook", "--no-browser", "--no-mathjax", "--port=8888", "--NotebookApp.port_retries=0"]
