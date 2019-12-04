TERMUX_PKG_HOMEPAGE=http://eigen.tuxfamily.org
TERMUX_PKG_DESCRIPTION="Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms"
TERMUX_PKG_LICENSE="MPL-2.0"
TERMUX_PKG_VERSION=3.3.7
TERMUX_PKG_REVISION=1
TERMUX_PKG_SHA256=a8d87c8df67b0404e97bcef37faf3b140ba467bc060e2b883192165b319cea8d
TERMUX_PKG_SRCURL=https://github.com/eigenteam/eigen-git-mirror/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_BREAKS="eigen-dev"
TERMUX_PKG_REPLACES="eigen-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_BUILD_TYPE=Release"
