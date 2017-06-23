version=7.950.1
wget http://sourceforge.net/projects/arma/files/armadillo-${version}.tar.xz
tar -xvf armadillo-${version}.tar.xz
cd armadillo-${version} && cmake . && make
