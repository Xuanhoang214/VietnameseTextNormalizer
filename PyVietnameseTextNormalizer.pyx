cimport cython
from libc.stddef cimport wchar_t

ctypedef wchar_t qwchar

cdef extern from "<Python.h>":
    cdef wchar_t* PyUnicode_AsWideCharString(object unicode, Py_ssize_t *size)
    cdef object PyUnicode_FromWideChar(const wchar_t *w, Py_ssize_t size)

cdef extern from "VietnameseTextNormalizer.h":
    cdef cppclass VietnameseTextNormalizer:
        qwchar *standardText
        VietnameseTextNormalizer() except +
        void Input(const qwchar *text) nogil
        void Normalize() nogil
        void GenStandardText() nogil

cdef class Normalizer(object):
    cdef VietnameseTextNormalizer normalizer

    def __cinit__(self):
        self.normalizer = VietnameseTextNormalizer()

    @cython.boundscheck(False)
    @cython.wraparound(False)
    @cython.initializedcheck(False)
    @cython.nonecheck(False)
    cdef str _normalize(self, str text):
        self.normalizer.Input(<qwchar *> PyUnicode_AsWideCharString(text, NULL))
        self.normalizer.Normalize()
        self.normalizer.GenStandardText()
        return PyUnicode_FromWideChar(<wchar_t *> self.normalizer.standardText, -1)

    @cython.boundscheck(False)
    @cython.wraparound(False)
    @cython.initializedcheck(False)
    @cython.nonecheck(False)
    def normalize(self, str text):
        return self._normalize(text)
