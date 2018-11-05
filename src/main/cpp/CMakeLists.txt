#       CMakeLists.txt
#
#               Copyright (c) 2014-2018 A.H.L
#
#        Permission is hereby granted, free of charge, to any person obtaining
#        a copy of this software and associated documentation files (the
#        "Software"), to deal in the Software without restriction, including
#        without limitation the rights to use, copy, modify, merge, publish,
#        distribute, sublicense, and/or sell copies of the Software, and to
#        permit persons to whom the Software is furnished to do so, subject to
#        the following conditions:
#
#        The above copyright notice and this permission notice shall be
#        included in all copies or substantial portions of the Software.
#
#        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#        EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#        MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#        NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#        LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#        OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#        WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


add_library(cfs.dev.tools.main
    cfs/dev/tools/Dummy
)
 
#apply_style_targets_command (cfs.dev.tools.main ${CMAKE_CURRENT_SOURCE_DIR})
#add_cppcheck_analysis_command(cfs.dev.tools.main ${CMAKE_CURRENT_SOURCE_DIR})
#add_code_linter_command(cfs.dev.tools.main ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
#add_cyclomatic_complexity_analyzer_command(cfs.dev.tools.main ${CMAKE_CURRENT_SOURCE_DIR})

option(EXCLUDE_DEPRECATED "Exclude deprecated parts of the library" TRUE)
if (EXCLUDE_DEPRECATED)
    set(NO_BUILD_DEPRECATED DEFINE_NO_DEPRECATED)
endif()

include(GenerateExportHeader)
generate_export_header(cfs.dev.tools.main
    EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/cfs/dev/tools/CfsDevToolsEcport.hpp"
    INCLUDE_GUARD_NAME CFS_DEV_TOOLS_EXPORT_HPP
    EXPORT_MACRO_NAME API_DECLS
    BASE_NAME cfs-dev-tools
    PREFIX_NAME CFS_DEV_TOOLS
    ##STATIC_DEFINE BUILT_AS_STATIC
    DEPRECATED_MACRO_NAME CFS_DEV_TOOLS_DEPRECATED
    ${NO_BUILD_DEPRECATED}
)

target_compile_features(cfs.dev.tools.main
    PUBLIC
        cxx_std_17
        cxx_strong_enums
        cxx_variadic_templates
        cxx_nullptr
        cxx_alias_templates
        cxx_auto_type
        cxx_constexpr
        cxx_defaulted_functions
        cxx_final
        cxx_lambdas
        cxx_noexcept
        cxx_nullptr
        cxx_rvalue_references
        cxx_thread_local
        cxx_variadic_templates
        cxx_override
    PRIVATE
        cxx_lambdas
        cxx_range_for
        $<$<CXX_COMPILER_ID:GNU>:cxx_attributes>
)

target_compile_definitions(cfs.dev.tools.main
    PRIVATE
        "VERBOSITY=$<IF:$<BOOL:${VERBOSE}>,30,10>"
        
)

target_compile_options(cfs.dev.tools.main
    INTERFACE
        $<$<CONFIG:Debug>:-g3 -O0 -fstack-protector>
        $<$<CONFIG:Release>:-g0 -O2>
    PUBLIC 
        $<$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:GNU>>: -W -Wextra -Weffc++ -Wall -pedantic-errors -Wconversion -Wsign-conversion>

        $<IF:$<COMPILE_LANGUAGE:CXX>,-Wold-style-cast,>

        $<$<CONFIG:Release>:${MY_RELEASE_OPTIONS}>
        $<$<CONFIG:Release>:-ffunction-sections>
        $<$<CONFIG:Release>:-fdata-sections>
        $<$<CONFIG:Release>:-Wl,--gc-sections>

        $<$<CONFIG:Debug>:${MY_DEBUG_OPTIONS}>
        $<$<CONFIG:Debug>:-O0>
        $<$<CONFIG:Debug>:-ggdb>
        $<$<CONFIG:Debug>: -O0 -g -D_DEBUG -D_FORTIFY_SOURCE=2 -fno-strict-aliasing -fno-omit-frame-pointer>

        $<$<CONFIG:Release>:API_DECLS>
        $<$<CONFIG:Release>:LOG4CXX_STATIC>
        $<$<CONFIG:Release>:APR_DECLARE_STATIC>
        $<$<OR:$<CONFIG:Release>,$<CONFIG:PROF>>:DISABLE_VAR>
#        $<IF:$<CONFIG:Debug>:helper_debug.cpp,helper_release.cpp>

        $<$<OR:$<CONFIG:Release>,$<CONFIG:Profile>>:DISABLE_CONTRACTIONS>

        $<$<COMPILE_LANGUAGE:CXX>:-DNDEBUG -O3 -pipe -Wpedantic>
        $<$<COMPILE_LANGUAGE:CXX>:-fmax-errors=5 -Werror=shadow -fdiagnostics-parseable-fixits>
        $<$<COMPILE_LANGUAGE:CXX>:-Wnon-virtual-dtor -Woverloaded-virtual -Wuseless-cast -Wlogical-op -Wduplicated-branches>


        $<$<CONFIG:Coverage>:-O0  -fprofile-arcs -ftest-coverage --coverage>

        $<$<CONFIG:Profile>:-fsanitize=memory -fsanitize-memory-track-origins=2 -fno-omit-frame-pointer -fsanitize=null>
        $<$<CONFIG:Profile>:-fsanitize=unreachable -fstack-check -fvtable-verify=std>
        
)

target_include_directories(cfs.dev.tools.main 
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/cfs/dev/tools>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
        $<INSTALL_INTERFACE:include/cfs/dev/tools>
    SYSTEM 
        PUBLIC
            ${CMAKE_INSTALL_INCLUDEDIR}/cfs/dev/tools
)

target_link_libraries(cfs.dev.tools.main
    PUBLIC 
        LOG4CXX::LOG4CXX
)

add_executable(cfs.dev.tools.main.bin
    cfs/dev/tools/main.cpp
)

target_link_libraries(cfs.dev.tools.main.bin
    PUBLIC cfs.dev.tools.main
)

add_dependencies(compile cfs.dev.tools.main.bin)

#EXPORT LIBRARY INTERFACE

#install(TARGETS cfs.dev.tools.main
#    EXPORT cfs.dev.tools.main-Targets
#    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
#    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
#    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cfs/dev/tools
#     FRAMEWORK DESTINATION ${FRAMEWORK_INSTALL_DIR}
#     PUBLIC_HEADER DESTINATION ${INCLUDE_INSTALL_DIR}/cfs/dev/tools
#)

#install(EXPORT cfs.dev.tools.main-Targets
#    DESTINATION lib/cmake/cfs/dev/tools
#    FILE cfs.dev.tools.main-Targets.cmake
#    NAMESPACE CFS::DEV::TOOLS
#)

#install(DIRECTORY include/cfs/dev/tools
#    DESTINATION include
#)

#include(CMakePackageConfigHelpers)
#write_basic_package_version_file(cfs-dev-tools-ConfigVersion.cmake
#    COMPATIBILITY AnyNewerVersion
#)

#install(FILES cfs-dev-tools-Config.cmake ${CMAKE_CURRENT_BINARY_DIR}/cfs-dev-tools-ConfigVersion.cmake
#    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/cfs-dev-tools
#)

