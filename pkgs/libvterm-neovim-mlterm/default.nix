{ mlterm, libvterm-neovim }:
mlterm.overrideAttrs (old: rec {
  pname = "libvterm-neovim-mlterm";

  buildInputs = old.buildInputs ++ [ libvterm-neovim ];

  postBuild = ''
    make vterm
  '';

  installPhase = ''
    cd baselib ; make install-la ; cd ..
    cd encodefilter ; make install-la ; cd ..
    make install-vterm

    mkdir -p $out/include
    cp ${libvterm-neovim}/include/* $out/include/

    mkdir -p $out/lib/pkgconfig
    cp ${libvterm-neovim}/lib/pkgconfig/vterm.pc $out/lib/pkgconfig/
    chmod +w $out/lib/pkgconfig/vterm.pc

    sed -i "s|${libvterm-neovim}|$out|g" $out/lib/pkgconfig/vterm.pc
  '';
})
