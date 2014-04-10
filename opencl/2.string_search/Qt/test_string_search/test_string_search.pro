TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

#Add CONFIG+=linuxPC or CONFIG+=imx6qSabreAuto in qmake inovocation.
#In qtcreator in left plane goto Projects -> under Build Steps add
#   CONFIG+=linuxPC in Additional Arguments section

imx6qSabreAuto {
    target.files = test_string_search
    target.path = /home/root/CL
    INSTALLS += target
    LIBS += -lOpenCL -lGAL

    copydata.commands = $(COPY_DIR) ../../string_search.cl ../../string_search.txt $$OUT_PWD
    first.depends = $(first) copydata
    export(first.depends)
    export(copydata.commands)
    QMAKE_EXTRA_TARGETS += first copydata
}

linuxPC {
    QT_CONFIG -= no-pkg-config
    CONFIG += link_pkgconfig
    #PKGCONFIG += opencv
    DEFINES += PLATFORM_LINUX EGL_LINUX BOOST_MT
    LIBS += -L/usr/local/lib/
    LIBS += -lGLESv2 -lEGL -lm -lX11 -lboost_system -lboost_thread -lOpenCL
    INCLUDEPATH += /usr/local/cuda-5.5/include/ #For CL Header on Nvidia Machine

    copydata.commands = $(COPY_DIR) ../../string_search.cl ../../string_search.txt $$OUT_PWD
    first.depends = $(first) copydata
    export(first.depends)
    export(copydata.commands)
    QMAKE_EXTRA_TARGETS += first copydata
}

########################################################################
#                   i-Vizon Template Section                           #
########################################################################

IVIZON_TRUNK    = /opt/i-vizon/trunk
UTILS           = $$IVIZON_TRUNK/utils
COMMON          = $$IVIZON_TRUNK/common
STDCPLUS          = $$IVIZON_TRUNK/c++11

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Common

HEADERS += $$COMMON/inc/common.h \
            ../../../wrapper/inc/buffer.h \
            ../../../wrapper/inc/kernel_launcher.h \
            ../../../wrapper/inc/program.h

SOURCES += $$COMMON/src/common.cpp

INCLUDEPATH += $$COMMON/inc/

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>OpenCL

OPENCL          = $$IVIZON_TRUNK/opencl
OPENCL_WRAPPER  = $$IVIZON_TRUNK/opencl/wrapper

SOURCES += $$OPENCL_WRAPPER/src/cl_wrapper.cpp \
            ../../../wrapper/src/buffer.cpp \
            ../../../wrapper/src/kernel_launcher.cpp \
            ../../../wrapper/src/program.cpp

HEADERS += $$OPENCL_WRAPPER/inc/cl_wrapper.hpp

INCLUDEPATH += $$OPENCL_WRAPPER/inc/

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>c++11

SOURCES += $$STDCPLUS/file_operation/file_operation.cpp
HEADERS += $$STDCPLUS/file_operation/file_operation.h
INCLUDEPATH += $$STDCPLUS/file_operation/

########################################################################
#                          Project Section                             #
########################################################################

SOURCES += main.cpp \
            ../../string_search.cpp

OTHER_FILES += ../../string_search.cl \
               ../../string_search.txt


