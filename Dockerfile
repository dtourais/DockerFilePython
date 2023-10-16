FROM centos:7

RUN yum -y install epel-release

RUN yum -y install python3 python3-pip python3-devel gcc-c++ make qt5-qtbase-devel qt5-qtbase-gui wget

RUN pip3 install --upgrade pip

RUN pip3 install numpy pandas geopandas csvkit PyQt5 matplotlib folium

RUN pip3 install pyinstaller

WORKDIR /app

CMD ["/bin/bash"]
