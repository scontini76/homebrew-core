class Binaryen < Formula
  desc "Compiler infrastructure and toolchain library for WebAssembly"
  homepage "http://webassembly.org/"
  url "https://github.com/WebAssembly/binaryen/archive/version_47.tar.gz"
  sha256 "596804438bc2b1ed21c8158c8e61cc1781beb4aee7c61f3126df02647cff1f09"

  head "https://github.com/WebAssembly/binaryen.git"

  bottle do
    cellar :any
    sha256 "d0ec801b8c772bc0b39d3d02e71c3eb18e7959a9d4fe65360623fc9edbcc408c" => :high_sierra
    sha256 "afa94e0153c2e45709aac6343deb5ba2da5b2aa43b592da15b5a704e86750e81" => :sierra
    sha256 "fe297417f5e087039ea4400c4abd0eda6e382d6272a0d8acebf00b3f68413bc8" => :el_capitan
  end

  depends_on "cmake" => :build
  depends_on :macos => :el_capitan # needs thread-local storage

  needs :cxx11

  def install
    ENV.cxx11

    system "cmake", ".", *std_cmake_args
    system "make", "install"

    pkgshare.install "test/"
  end

  test do
    system "#{bin}/wasm-opt", "#{pkgshare}/test/passes/O.wast"
    system "#{bin}/asm2wasm", "#{pkgshare}/test/hello_world.asm.js"
  end
end
