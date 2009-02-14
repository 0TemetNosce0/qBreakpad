## breakpad-qt
INCLUDEPATH += $$PWD/handler
HEADERS += $$PWD/handler/BreakpadHandler.h
SOURCES += $$PWD/handler/BreakpadHandler.cpp

## google-breakpad
BREAKPAD_PATH = $$PWD/third-party/google-breakpad/src
INCLUDEPATH += $$BREAKPAD_PATH
SOURCES += $$BREAKPAD_PATH/client/minidump_file_writer.cc \
    $$BREAKPAD_PATH/common/string_conversion.cc \
    $$BREAKPAD_PATH/common/convert_UTF.c \
    $$BREAKPAD_PATH/common/md5.c

mac { 
    # hack to make minidump_generator.cc compile as it uses
    # esp instead of __esp
    # DEFINES += __DARWIN_UNIX03=0 -- looks like we doesn't need it anymore
    SOURCES += $$BREAKPAD_PATH/client/mac/handler/exception_handler.cc \
        $$BREAKPAD_PATH/client/mac/handler/minidump_generator.cc \
        $$BREAKPAD_PATH/client/mac/handler/dynamic_images.cc \
        $$BREAKPAD_PATH/common/mac/string_utilities.cc \
        $$BREAKPAD_PATH/common/mac/file_id.cc \
        $$BREAKPAD_PATH/common/mac/macho_id.cc \
        $$BREAKPAD_PATH/common/mac/macho_utilities.cc \
        $$BREAKPAD_PATH/common/mac/macho_walker.cc
    LIBS += -lcrypto
}

unix:!mac {
    SOURCES += $$BREAKPAD_PATH/client/linux/handler/exception_handler.cc \
        $$BREAKPAD_PATH/client/linux/handler/minidump_generator.cc \
        $$BREAKPAD_PATH/client/linux/handler/linux_thread.cc \
        $$BREAKPAD_PATH/common/linux/guid_creator.cc \
        $$BREAKPAD_PATH/common/linux/file_id.cc
}

win32 {
    warning("win32 platform is untested!")
}
