cmake_minimum_required(VERSION 3.16)
project(qml-hmi-navigator VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(qml-hmi-navigator
    main.cpp
)

qt_add_qml_module(qml-hmi-navigator
    URI HmiNavigator
    VERSION 1.0
    NO_GENERATE_QMLDIR
    QML_FILES
        Main.qml
        NavigationTree.qml
        ScreenRegistry.qml
        ThemeObject.qml
        NavigatorShell.qml
        NavButton.qml
        NavHeader.qml
        screens/MenuScreen.qml
        screens/LeafScreenA.qml
    RESOURCES
        qmldir
)

target_link_libraries(qml-hmi-navigator PRIVATE Qt6::Quick)

set_target_properties(qml-hmi-navigator PROPERTIES
    WIN32_EXECUTABLE TRUE
)
