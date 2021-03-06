#-------------------------------------------------
#
# Project created by QtCreator 2016-12-28T18:23:35
#
#-------------------------------------------------

message(----)

QT                += widgets core gui network multimedia svg
CONFIG            += communi
COMMUNI           += core model util
CONFIG            += c++14
INCLUDEPATH       += src/
TARGET             = chatterino
TEMPLATE           = app
DEFINES           += QT_DEPRECATED_WARNINGS
PRECOMPILED_HEADER = src/precompiled_header.hpp
CONFIG            += precompile_header

# https://bugreports.qt.io/browse/QTBUG-27018
equals(QMAKE_CXX, "clang++") {
    TARGET = bin/chatterino
}

# Icons
macx:ICON = resources/images/chatterino2.icns
win32:RC_FILE = resources/windows.rc

# Submodules
include(dependencies/rapidjson.pri)
include(dependencies/settings.pri)
include(dependencies/signals.pri)
include(dependencies/humanize.pri)
include(dependencies/fmt.pri)
DEFINES += IRC_NAMESPACE=Communi
include(dependencies/libcommuni.pri)

# Optional feature: QtWebEngine
exists ($(QTDIR)/include/QtWebEngine/QtWebEngine) {
    message(Using QWebEngine)
    QT += webenginewidgets
    DEFINES += "USEWEBENGINE"
}

# Include boost
win32 {
    isEmpty(BOOST_DIRECTORY) {
        message(Using default boost directory C:\\local\\boost\\)
        BOOST_DIRECTORY = C:\local\boost\
    }

    INCLUDEPATH += $$BOOST_DIRECTORY
}

win32 {
    LIBS += -luser32
}

# OSX include directory
macx {
    INCLUDEPATH += /usr/local/include
}

# Optional dependency on Windows SDK 7
!contains(QMAKE_TARGET.arch, x86_64) {
    win32:exists(C:\Program Files\Microsoft SDKs\Windows\v7.1\Include\Windows.h) {
        LIBS += -L"C:\Program Files\Microsoft SDKs\Windows\v7.1\Lib" \
            -ldwmapi

        DEFINES += "USEWINSDK"
        message(Using Windows SDK 7)
    }
}

# Optional dependency on Windows SDK 10
contains(QMAKE_TARGET.arch, x86_64) {
    WIN_SDK_VERSION = $$(WindowsSDKVersion)
    !isEmpty(WIN_SDK_VERSION) {
        !equals(WIN_SDK_VERSION, "\\") {
            DEFINES += "USEWINSDK"
            message(Using Windows SDK 10)
        }
    }
}

werr {
    QMAKE_CXXFLAGS += -Werror

    message("Enabling error on warning")
}

# src
SOURCES += \
    src/main.cpp \
    src/application.cpp \
    src/channel.cpp \
    src/channeldata.cpp \
    src/messages/image.cpp \
    src/messages/layouts/messagelayout.cpp \
    src/messages/layouts/messagelayoutcontainer.cpp \
    src/messages/layouts/messagelayoutelement.cpp \
    src/messages/link.cpp \
    src/messages/message.cpp \
    src/messages/messagebuilder.cpp \
    src/messages/messagecolor.cpp \
    src/messages/messageelement.cpp \
    src/providers/irc/abstractircserver.cpp \
    src/providers/twitch/ircmessagehandler.cpp \
    src/providers/twitch/twitchaccount.cpp \
    src/providers/twitch/twitchaccountmanager.cpp \
    src/providers/twitch/twitchchannel.cpp \
    src/providers/twitch/twitchmessagebuilder.cpp \
    src/providers/twitch/twitchserver.cpp \
    src/singletons/accountmanager.cpp \
    src/singletons/channelmanager.cpp \
    src/singletons/commandmanager.cpp \
    src/singletons/emotemanager.cpp \
    src/singletons/fontmanager.cpp \
    src/util/completionmodel.cpp \
    src/singletons/helper/loggingchannel.cpp \
    src/singletons/helper/moderationaction.cpp \
    src/singletons/loggingmanager.cpp \
    src/singletons/pathmanager.cpp \
    src/singletons/resourcemanager.cpp \
    src/singletons/settingsmanager.cpp \
    src/singletons/thememanager.cpp \
    src/singletons/windowmanager.cpp \
    src/util/networkmanager.cpp \
    src/util/networkrequest.cpp \
    src/widgets/accountpopup.cpp \
    src/widgets/accountswitchpopupwidget.cpp \
    src/widgets/accountswitchwidget.cpp \
    src/widgets/basewidget.cpp \
    src/widgets/basewindow.cpp \
    src/widgets/emotepopup.cpp \
    src/widgets/helper/channelview.cpp \
    src/widgets/helper/droppreview.cpp \
    src/widgets/helper/label.cpp \
    src/widgets/helper/notebookbutton.cpp \
    src/widgets/helper/notebooktab.cpp \
    src/widgets/helper/resizingtextedit.cpp \
    src/widgets/helper/rippleeffectbutton.cpp \
    src/widgets/helper/rippleeffectlabel.cpp \
    src/widgets/helper/scrollbarhighlight.cpp \
    src/widgets/helper/searchpopup.cpp \
    src/widgets/helper/settingsdialogtab.cpp \
    src/widgets/helper/splitcolumn.cpp \
    src/widgets/helper/splitheader.cpp \
    src/widgets/helper/splitinput.cpp \
    src/widgets/helper/titlebarbutton.cpp \
    src/widgets/logindialog.cpp \
    src/widgets/notebook.cpp \
    src/widgets/qualitypopup.cpp \
    src/widgets/scrollbar.cpp \
    src/widgets/settingsdialog.cpp \
    src/widgets/settingspages/aboutpage.cpp \
    src/widgets/settingspages/accountspage.cpp \
    src/widgets/settingspages/appearancepage.cpp \
    src/widgets/settingspages/behaviourpage.cpp \
    src/widgets/settingspages/commandpage.cpp \
    src/widgets/settingspages/emotespage.cpp \
    src/widgets/settingspages/highlightingpage.cpp \
    src/widgets/settingspages/ignoremessagespage.cpp \
    src/widgets/settingspages/ignoreuserspage.cpp \
    src/widgets/settingspages/keyboardsettingspage.cpp \
    src/widgets/settingspages/logspage.cpp \
    src/widgets/settingspages/moderationpage.cpp \
    src/widgets/settingspages/settingspage.cpp \
    src/widgets/settingspages/specialchannelspage.cpp \
    src/widgets/split.cpp \
    src/widgets/splitcontainer.cpp \
    src/widgets/streamview.cpp \
    src/widgets/textinputdialog.cpp \
    src/widgets/tooltipwidget.cpp \
    src/widgets/window.cpp \
    src/providers/irc/ircaccount.cpp \
    src/providers/irc/ircserver.cpp \
    src/providers/irc/ircchannel2.cpp \
    src/util/streamlink.cpp

HEADERS  += \
    src/precompiled_header.hpp \
    src/channel.hpp \
    src/const.hpp \
    src/debug/log.hpp \
    src/emojis.hpp \
    src/messages/highlightphrase.hpp \
    src/messages/image.hpp \
    src/messages/layouts/messagelayout.hpp \
    src/messages/layouts/messagelayoutcontainer.hpp \
    src/messages/layouts/messagelayoutelement.hpp \
    src/messages/limitedqueue.hpp \
    src/messages/limitedqueuesnapshot.hpp \
    src/messages/link.hpp \
    src/messages/message.hpp \
    src/messages/messagebuilder.hpp \
    src/messages/messagecolor.hpp \
    src/messages/messageelement.hpp \
    src/messages/messageparseargs.hpp \
    src/messages/selection.hpp \
    src/providers/twitch/emotevalue.hpp \
    src/providers/twitch/ircmessagehandler.hpp \
    src/providers/twitch/twitchaccount.hpp \
    src/providers/twitch/twitchaccountmanager.hpp \
    src/providers/twitch/twitchchannel.hpp \
    src/providers/twitch/twitchmessagebuilder.hpp \
    src/providers/twitch/twitchserver.hpp \
    src/singletons/accountmanager.hpp \
    src/singletons/channelmanager.hpp \
    src/singletons/commandmanager.hpp \
    src/singletons/emotemanager.hpp \
    src/singletons/fontmanager.hpp \
    src/singletons/helper/chatterinosetting.hpp \
    src/util/completionmodel.hpp \
    src/singletons/helper/loggingchannel.hpp \
    src/singletons/helper/moderationaction.hpp \
    src/singletons/loggingmanager.hpp \
    src/singletons/pathmanager.hpp \
    src/singletons/resourcemanager.hpp \
    src/singletons/settingsmanager.hpp \
    src/singletons/thememanager.hpp \
    src/singletons/windowmanager.hpp \
    src/util/benchmark.hpp \
    src/util/concurrentmap.hpp \
    src/util/distancebetweenpoints.hpp \
    src/util/emotemap.hpp \
    src/util/flagsenum.hpp \
    src/util/helpers.hpp \
    src/util/irchelpers.hpp \
    src/util/layoutcreator.hpp \
    src/util/nativeeventhelper.hpp \
    src/util/networkmanager.hpp \
    src/util/networkrequest.hpp \
    src/util/networkrequester.hpp \
    src/util/networkworker.hpp \
    src/util/posttothread.hpp \
    src/util/property.hpp \
    src/util/serialize-custom.hpp \
    src/util/urlfetch.hpp \
    src/widgets/accountpopup.hpp \
    src/widgets/accountswitchpopupwidget.hpp \
    src/widgets/accountswitchwidget.hpp \
    src/widgets/basewidget.hpp \
    src/widgets/basewindow.hpp \
    src/widgets/emotepopup.hpp \
    src/widgets/helper/channelview.hpp \
    src/widgets/helper/droppreview.hpp \
    src/widgets/helper/label.hpp \
    src/widgets/helper/notebookbutton.hpp \
    src/widgets/helper/notebooktab.hpp \
    src/widgets/helper/resizingtextedit.hpp \
    src/widgets/helper/rippleeffectbutton.hpp \
    src/widgets/helper/rippleeffectlabel.hpp \
    src/widgets/helper/scrollbarhighlight.hpp \
    src/widgets/helper/searchpopup.hpp \
    src/widgets/helper/settingsdialogtab.hpp \
    src/widgets/helper/shortcut.hpp \
    src/widgets/helper/signallabel.hpp \
    src/widgets/helper/splitcolumn.hpp \
    src/widgets/helper/splitheader.hpp \
    src/widgets/helper/splitinput.hpp \
    src/widgets/helper/titlebarbutton.hpp \
    src/widgets/notebook.hpp \
    src/widgets/qualitypopup.hpp \
    src/widgets/scrollbar.hpp \
    src/widgets/settingsdialog.hpp \
    src/widgets/settingspages/aboutpage.hpp \
    src/widgets/settingspages/accountspage.hpp \
    src/widgets/settingspages/appearancepage.hpp \
    src/widgets/settingspages/behaviourpage.hpp \
    src/widgets/settingspages/commandpage.hpp \
    src/widgets/settingspages/emotespage.hpp \
    src/widgets/settingspages/highlightingpage.hpp \
    src/widgets/settingspages/ignoremessagespage.hpp \
    src/widgets/settingspages/ignoreuserspage.hpp \
    src/widgets/settingspages/keyboardsettingspage.hpp \
    src/widgets/settingspages/logspage.hpp \
    src/widgets/settingspages/moderationpage.hpp \
    src/widgets/settingspages/settingspage.hpp \
    src/widgets/settingspages/specialchannelspage.hpp \
    src/widgets/split.hpp \
    src/widgets/splitcontainer.hpp \
    src/widgets/streamview.hpp \
    src/widgets/textinputdialog.hpp \
    src/widgets/tooltipwidget.hpp \
    src/widgets/window.hpp \
    src/common.hpp \
    src/providers/irc/abstractircserver.hpp \
    src/providers/irc/ircaccount.hpp \
    src/providers/irc/ircserver.hpp \
    src/providers/irc/ircchannel2.hpp \
    src/util/streamlink.hpp

RESOURCES += \
    resources/resources.qrc

DISTFILES +=

FORMS += \
    forms/accountpopupform.ui

# Define warning flags for Chatterino
win32-msvc* {
    QMAKE_CXXFLAGS_WARN_ON = /W4
    # 4714 - function marked as __forceinline not inlined
    # 4996 - occurs when the compiler encounters a function or variable that is marked as deprecated.
    #        These functions may have a different preferred name, may be insecure or have
    #        a more secure variant, or may be obsolete.
    # 4505 - unreferenced local version has been removed
    # 4127 - conditional expression is constant
    # 4503 - decorated name length exceeded, name was truncated
    # 4100 - unreferences formal parameter
    QMAKE_CXXFLAGS_WARN_ON += /wd4714
    QMAKE_CXXFLAGS_WARN_ON += /wd4996
    QMAKE_CXXFLAGS_WARN_ON += /wd4505
    QMAKE_CXXFLAGS_WARN_ON += /wd4127
    QMAKE_CXXFLAGS_WARN_ON += /wd4503
    QMAKE_CXXFLAGS_WARN_ON += /wd4100

} else {
    QMAKE_CXXFLAGS_WARN_ON = -Wall
    QMAKE_CXXFLAGS_WARN_ON += -Wno-unused-function
    QMAKE_CXXFLAGS_WARN_ON += -Wno-switch
    QMAKE_CXXFLAGS_WARN_ON += -Wno-deprecated-declarations
}

# do not use windows min/max macros
#win32 {
#    DEFINES += NOMINMAX
#}

#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

win32::exists(C:\fourtf) {
    DEFINES += "OHHEYITSFOURTF"
}
