FROM ghcr.io/modfy/conda:latest

WORKDIR /usr/src/app



COPY *.yml *.sh ./

COPY FuSta ./FuSta



RUN conda update --name base --channel defaults conda && \
    conda env create --name FuSta --file /usr/src/app/environment.yml --force && \
    conda env create --name FuSta_CVPR2020 --file /usr/src/app/environment-smoothflow.yml --force && \
    conda clean --all --yes

SHELL ["conda", "run", "-n", "FuSta_CVPR2020", "/bin/bash", "-c"]

RUN pip install -r /usr/src/app/FuSta/CVPR2020CODE_yulunliu_modified/requirements_CVPR2020.txt
RUN chmod u+x /usr/src/app/FuSta/CVPR2020CODE_yulunliu_modified/install.sh
RUN cd /usr/src/app/FuSta/CVPR2020CODE_yulunliu_modified/ && bash install.sh

RUN cd FuSta/CVPR2020CODE_yulunliu_modified/ && wget https://www.cmlab.csie.ntu.edu.tw/~yulunliu/FuSta/CVPR2020_ckpts.zip && unzip CVPR2020_ckpts.zip


RUN conda install pytorch=1.6.0 torchvision=0.7.0 cudatoolkit=10.1 -c pytorch
RUN conda install matplotlib
RUN conda install opencv
RUN conda install tensorboard
RUN conda install scipy
RUN conda install -c conda-forge cupy cudatoolkit=10.1



RUN pip install PyMaxflow