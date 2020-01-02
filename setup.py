from Cython.Distutils import build_ext
from distutils.core import setup
from distutils.extension import Extension

ext_modules = [
    Extension(
        "PyVietnameseTextNormalizer",
        [
            "PyVietnameseTextNormalizer.pyx",
            "ContextSystem.cpp",
            "PhonemeSystem.cpp",
            "SyllableSystem.cpp",
            "VietnameseTextNormalizer.cpp",
            "WordSystem.cpp",
        ],
        language="c++",
        extra_compile_args=[
            "-Wno-cpp",
            "-Wno-unused-function",
            "-march=native",
            "-O2",
        ],
        include_dirs=["."],
    )
]

setup(
    name="VietnameseTextNormalizer",
    version="1.2a",
    ext_modules=ext_modules,
    cmdclass={"build_ext": build_ext},
)
