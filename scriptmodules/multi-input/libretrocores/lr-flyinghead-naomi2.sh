#!/usr/bin/env bash

# This file is not part of The RetroPie Project

rp_module_id="lr-flyinghead-naomi2"
rp_module_desc="Multi-platform Sega Dreamcast, naomi2 and Atomiswave emulator derived from Reicast"
rp_module_help="Dreamcast ROM Extensions: .cdi .gdi .chd .m3u, naomi2/Atomiswave ROM Extension: .zip\n\nCopy your Dreamcast/naomi2 roms to $romdir/dreamcast\n\nCopy the required Dreamcast BIOS file dc_boot.bin to $biosdir/dc\n\nCopy the required naomi2/Atomiswave BIOS files naomi2.zip and awbios.zip to $biosdir/dc"
rp_module_licence="GPL2 https://raw.githubusercontent.com/flyinghead/flycast/master/LICENSE"
rp_module_repo="git https://github.com/flyinghead/flycast.git master"
rp_module_section="opt"
rp_module_flags="!armv6"

function depends_lr-flyinghead-naomi2() {
    local depends=(cmake zlib1g-dev libzip-dev)
    isPlatform "videocore" && depends+=(libraspberrypi-dev)
    isPlatform "mesa" && depends+=(libgles2-mesa-dev)
    isPlatform "x11" && depends+=(libgl-dev)
    getDepends "${depends[@]}"
}

function sources_lr-flyinghead-naomi2() {
    gitPullOrClone
}

function build_lr-flyinghead-naomi2() {
    local params=("-DLIBRETRO=On -DUSE_HOST_LIBZIP=On -DCMAKE_BUILD_TYPE=Release")
    local add_flags=()
    if isPlatform "gles" && ! isPlatform "gles3" ; then
        if isPlatform "videocore"; then
            add_flags+=("-I/opt/vc/include -DLOW_END")
            params+=("-DUSE_VIDEOCORE=On")
        fi
        params+=("-DUSE_GLES2=On")
    fi

    isPlatform "gles3" && params+=("-DUSE_GLES=On")
    ! isPlatform "x86" && params+=("-DUSE_VULKAN=Off")

    mkdir -p build
    cd build
    CFLAGS="$CFLAGS ${add_flags[@]}" CXXFLAGS="$CXXFLAGS ${add_flags}" cmake "${params[@]}" ..
    make
    md_ret_require="$md_build/build/flycast_libretro.so"
}

function install_lr-flyinghead-naomi2() {
    md_ret_files=(
        'build/flycast_libretro.so'
        'LICENSE'
        'README.md'
    )
}

function configure_lr-flyinghead-naomi2() {
    mkRomDir "naomi2"
    ensureSystemretroconfig "naomi2"

    mkUserDir "$biosdir/dc"

    # system-specific
    if isPlatform "gl"; then
        iniConfig " = " "" "$configdir/naomi2/retroarch.cfg"
        iniSet "video_shared_context" "true"
    fi

    local def=0
    isPlatform "kms" && def=1
    # segfaults on the rpi without redirecting stdin from </dev/null
    addEmulator $def "$md_id" "naomi2" "$md_inst/flycast_libretro.so </dev/null"
    addSystem "namoi"
}