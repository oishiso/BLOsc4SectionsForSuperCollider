cmake_minimum_required(VERSION 3.15)

project(BLOsc4sections)

# SuperColliderのインクルードディレクトリを設定
set(SUPERCOLLIDER_PLUGIN_INTERFACE_PATH "/Users/so/supercollider/include/plugin_interface")
set(SUPERCOLLIDER_COMMON_PATH "/Users/so/supercollider/include/common")

include_directories(${SUPERCOLLIDER_PLUGIN_INTERFACE_PATH} ${SUPERCOLLIDER_COMMON_PATH})

# BLOsc4sectionsライブラリを作成
add_library(BLOsc4sections MODULE BLOsc4sections.cpp)


# コンパイルオプションを設定
target_compile_options(BLOsc4sections PRIVATE -arch arm64 -std=c++17)
target_compile_definitions(BLOsc4sections PRIVATE SC_USE_FASTCALL=0)
