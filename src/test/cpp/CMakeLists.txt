
add_library(cfs.dev.tools.test
    cfs/dev/tools/Test
)

apply_style_targets_command(cfs.dev.tools.test ${CMAKE_CURRENT_SOURCE_DIR})
target_include_directories(cfs.dev.tools.test 
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/cfs/dev/tools>
        $<INSTALL_INTERFACE:${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cfs/dev/tools>
)

target_link_libraries(cfs.dev.tools.test
    PUBLIC  
        cfs.dev.tools.main
        GMock::GMock
        GTest::GTest
)

add_executable (cfs.dev.tools.test.bin
    cfs/dev/tools/unitTest
    cfs/dev/tools/DummyTest
)

target_link_libraries(cfs.dev.tools.test.bin
    PUBLIC cfs.algo.test
)

gtest_discover_tests(cfs.dev.tools.test.bin
    TEST_PREFIX "CFS-DEC-TOOLS:-: "
    TEST_SUFFIX ----
    PROPERTIES LABELS CFS_DEV_TOOLS TEST
    DISCOVERY_TIMEOUT 10
    EXTRA_ARGS --iterration 1 --outputpath ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} --module cfs.dev.tools.test
    WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
)

add_dependencies( test-compile cfs.dev.tools.test.bin)

