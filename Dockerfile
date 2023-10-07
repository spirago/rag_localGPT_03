# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to avoid any prompts during package installation
ENV PATH = "/usr/local/bin:$PATH"
# ENV PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjS9jZFlpVRQLFMFoV3kBdz+lxMOaBxSJ1eFioVZ5+c oli2@poczta.onet.pl"
ARG PATH="/root/miniconda3/bin:$PATH"

# Update and install some basic packages
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    mercurial \
    subversion

# Set up Miniconda
# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
#     /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#     rm ~/miniconda.sh && \
#     /opt/conda/bin/conda clean -tipsy && \
#     ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
#     echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
#     echo "conda activate base" >> ~/.bashrc
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh


# Add conda to PATH
# ENV PATH /opt/conda/bin:$PATH


# # Install pip in the base conda environment
RUN conda install -y pip

# # Create a new conda environment with Python 3.10 named ludwig (Replace 3.10 with the version you need)
RUN conda create -y --name privategpt python=3.10
RUN echo "source activate privategpt" > ~/.bashrc
ENV PATH="/root/miniconda3/bin:$PATH"

# # Initialize conda in shell script so conda command can be used
SHELL ["conda", "run", "-n", "privategpt", "/bin/bash", "-c"]

# # Install Ludwig using pip in the ludwig environment
# RUN pip install ludwig --no-cache-dir

# # Set the default environment to ludwig when starting the container
ENV CONDA_DEFAULT_ENV=privategpt

# # # Set working directory
WORKDIR /

# conda init bash
# source ~/.bashrc
# conda activate ludwig


# # # The command that will be run when the container starts
ADD start.sh /
# ADD ludwig_finetune.py /
RUN chmod +x /start.sh
CMD ["/start.sh"]