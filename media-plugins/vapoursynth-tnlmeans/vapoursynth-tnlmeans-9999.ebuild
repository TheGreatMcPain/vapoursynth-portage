# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs multilib

DESCRIPTION="VapourSynth port of TNLMeans"
HOMEPAGE="https://github.com/VFR-maniac/VapourSynth-TNLMeans"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/VFR-maniac/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/VFR-maniac/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	eapply_user
	chmod +x configure
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCC)\":" configure || die
	sed -i -e "s:LD=\"g++\":LD=\"$(tc-getCC)\":" configure || die
}

src_configure() {
	./configure --prefix="${ROOT}/usr" \
				--libdir="${ROOT}/usr/$(get_libdir)" \
				--extra-cxxflags="${CXXFLAGS}" \
				--extra-ldflags="${LDFLAGS}" || die
}
