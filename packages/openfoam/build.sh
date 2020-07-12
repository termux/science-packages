TERMUX_PKG_HOMEPAGE=https://www.openfoam.com
TERMUX_PKG_DESCRIPTION="OpenFOAM is a CFD software written in C++"
TERMUX_PKG_MAINTAINER="Henrik Grimler @Grimler91"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_VERSION=2012
TERMUX_PKG_SRCURL=https://sourceforge.net/projects/openfoam/files/v2012/OpenFOAM-v$TERMUX_PKG_VERSION.tgz
TERMUX_PKG_SHA256=3d6e39e39e7ae61d321fbc6db6c3748e6e5e1c4886454207a7f1a7321469e65a
TERMUX_PKG_DEPENDS="openmpi, flex, boost, cgal, libc++"
TERMUX_PKG_RM_AFTER_INSTALL="opt/OpenFOAM-v${TERMUX_PKG_VERSION}/build"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_HOSTBUILD=true

termux_step_host_build() {
	(
		cd $TERMUX_PKG_SRCDIR
		set +u
		source etc/bashrc WM_ARCH_OPTION=32 || true
		cd wmake/src
		make
		source ../../etc/bashrc WM_ARCH_OPTION=64 || true
		set -u
		make
	)
	mkdir -p platforms/tools
	mv $TERMUX_PKG_SRCDIR/platforms/tools/linuxGcc platforms/tools/
	mv $TERMUX_PKG_SRCDIR/platforms/tools/linux64Gcc platforms/tools/
}

termux_step_pre_configure() {
	if [ "$TERMUX_ARCH" == "aarch64" ]; then
		ARCH_FOLDER=linuxARM64Clang
		TERMUX_COMPILER_PREFIX="aarch64-linux-android"
		export ARCH=aarch64
	elif [ "$TERMUX_ARCH" == "arm" ]; then
		ARCH_FOLDER=linuxARM7Clang
		TERMUX_COMPILER_PREFIX="arm-linux-androideabi"
		export ARCH=armv7l
	elif [ "$TERMUX_ARCH" == "i686" ]; then
		ARCH_FOLDER=linuxClang
		TERMUX_COMPILER_PREFIX="i686-linux-android"
		export ARCH=i686
	elif [ "$TERMUX_ARCH" == "x86_64" ]; then
		ARCH_FOLDER=linux64Clang
		TERMUX_COMPILER_PREFIX="x86_64-linux-android"
		export ARCH=x86_64
	fi
	sed -i "s%\@TERMUX_COMPILER_PREFIX\@%${TERMUX_COMPILER_PREFIX}%g" "$TERMUX_PKG_SRCDIR/wmake/rules/General/Clang/c"
	sed -i "s%\@TERMUX_COMPILER_PREFIX\@%${TERMUX_COMPILER_PREFIX}%g" "$TERMUX_PKG_SRCDIR/wmake/rules/General/Clang/c++"
	sed -i "s%\@TERMUX_COMPILER_PREFIX\@%${TERMUX_COMPILER_PREFIX}%g" "$TERMUX_PKG_SRCDIR/wmake/rules/General/general"
	#Lots and lots of unset env. variables that "set -u" complains about
	set +u
	source "$TERMUX_PKG_SRCDIR/etc/bashrc" || true
	set -u
	mkdir -p platforms/tools
	cp -r $TERMUX_PKG_HOSTBUILD_DIR/platforms/tools/linux64Gcc platforms/tools/${ARCH_FOLDER}
	if [ $TERMUX_ARCH_BITS = 32 ]; then
		cp -r $TERMUX_PKG_HOSTBUILD_DIR/platforms/tools/linuxGcc platforms/tools/${ARCH_FOLDER}
	else
		cp -r $TERMUX_PKG_HOSTBUILD_DIR/platforms/tools/linux64Gcc platforms/tools/${ARCH_FOLDER}
	fi
}

termux_step_make() {
	unset LD_LIBRARY_PATH
	./Allwmake
	cd wmake/src
	make clean
	make
}

termux_step_make_install() {
	mkdir -p $TERMUX_PKG_MASSAGEDIR$TERMUX_PREFIX/opt
	cp -r $TERMUX_PKG_SRCDIR $TERMUX_PKG_MASSAGEDIR$TERMUX_PREFIX/opt/OpenFOAM-v${TERMUX_PKG_VERSION}
}

termux_step_post_make_install() {
	sed -i 's%$ARCH%$(uname -m)%g' $TERMUX_PKG_MASSAGEDIR$TERMUX_PREFIX/opt/OpenFOAM-v${TERMUX_PKG_VERSION}/etc/config.sh/settings
}
