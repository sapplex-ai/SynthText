#FROM python:3.9.1
FROM pytorch/pytorch

COPY . /app
WORKDIR /app

RUN apt-get update -y
RUN apt-get install -y build-essential vim
RUN apt-get install -y ghostscript libgs-dev
RUN apt-get install -y libmagickwand-dev imagemagick --fix-missing
RUN apt-get install -y libpng-dev zlib1g-dev libjpeg-dev libgl1-mesa-dev
RUN apt-get install -y python-pip python-dev
RUN pip install --upgrade pip

# Install python dependencies
RUN pip install -r requirements_sapplex.txt

# Install Pytorch stuff
RUN pip install torch==1.9.1+cu111 torchvision==0.10.1+cu111 torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html

# Install FB's detectron2
RUN python -m pip install detectron2 -f \
  https://dl.fbaipublicfiles.com/detectron2/wheels/cu111/torch1.9/index.html

EXPOSE 5200/tcp
EXPOSE 8080/tcp
EXPOSE 8888/tcp