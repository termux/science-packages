TERMUX_SUBPKG_DESCRIPTION="Texlive's collection-formatsextra"
TERMUX_SUBPKG_DEPENDS="texlive-langcyrillic, texlive-mathscience, texlive-fontsrecommended, texlive-plaingeneric"
TERMUX_SUBPKG_INCLUDE=$(python3 $TERMUX_PKG_BUILDER_DIR/parse_tlpdb.py formatsextra $TERMUX_PKG_TMPDIR/texlive.tlpdb)
TERMUX_SUBPKG_CONFLICTS="texlive-bin (<< 20190410), texlive (<< 20190410)"

termux_step_create_subpkg_debscripts() {
	echo "#!$TERMUX_PREFIX/bin/sh" > postinst
	echo mktexlsr >> postinst
}