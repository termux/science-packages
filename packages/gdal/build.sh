TERMUX_PKG_HOMEPAGE=https://gdal.org
TERMUX_PKG_DESCRIPTION="A translator library for raster and vector geospatial data formats"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="LICENSE.TXT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=3.3.2
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://download.osgeo.org/gdal/${TERMUX_PKG_VERSION}/gdal-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=630e34141cf398c3078d7d8f08bb44e804c65bbf09807b3610dcbfbc37115cc3
TERMUX_PKG_DEPENDS="libc++, openjpeg, libcurl, libtiff, libpng, proj, libiconv, libsqlite, libgeos, libspatialite, libexpat, postgresql, netcdf-c"
TERMUX_PKG_BREAKS="gdal-dev"
TERMUX_PKG_REPLACES="gdal-dev"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-sqlite3=$TERMUX_PREFIX
--with-spatialite=$TERMUX_PREFIX
--with-expat=$TERMUX_PREFIX
"
