FROM hub.bccvl.org.au/jupyter/base-notebook:0.9.4-16

# pre install some useful packgaes
RUN conda create --name py36 --yes \
      bokeh \
      cartopy \
      cython \
      gcc_linux-64 \
      gdal \
      ipykernel \
      ipympl \
      ipywidgets \
      nomkl \
      numba \
      pandas \
      python=3.6 \
      pyproj \
      rasterio \
      scikit-learn \
      scikit-image \
      scipy \
      seaborn \
      statsmodels \
      netCDF4 \
 && ${CONDA_DIR}/bin/conda clean -tipsy \
 && rm -fr /home/$NB_USER/{.cache,.conda,.npm}

# packages not available in conda standard stream
#TODO: does this version need to match nbextension?
RUN ${CONDA_DIR}/envs/py36/bin/pip install --no-cache-dir \
      ipyleaflet

# Import matplotlib the first time to build the font cache.
ENV DEFAULT_KERNEL_NAME=conda-env-py36-py \
    XDG_CACHE_HOME=/home/$NB_USER/.cache

RUN MPLBACKEND=Agg ${CONDA_DIR}/envs/py36/bin/python -c "import matplotlib.pyplot"

# TODO: pydap?
