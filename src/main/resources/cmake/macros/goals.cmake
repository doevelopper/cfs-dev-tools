

if(NOT TARGET ${PROJECT_NAME}-release)
	add_custom_target(${PROJECT_NAME}-release
		COMMAND
            ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Release ${CMAKE_SOURCE_DIR}
        WORKING_DIRECTORY
            ${CMAKE_SOURCE_DIR}/build-${CMAKE_BUILD_TYPE}
		COMMAND
            ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target all WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build-${CMAKE_BUILD_TYPE}
		COMMENT
            "Switch CMAKE_BUILD_TYPE to Release. Building  Release application"
	)
endif()

if(NOT TARGET ${PROJECT_NAME}-debug)
	add_custom_target(${PROJECT_NAME}-debug
		COMMAND
            ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Debug ${CMAKE_SOURCE_DIR}
        WORKING_DIRECTORY
            ${CMAKE_SOURCE_DIR}/build-${CMAKE_BUILD_TYPE} #${PROJECT_SOURCE_DIR} vs ${CMAKE_SOURCE_DIR}
		COMMAND
            ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target all WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build-${CMAKE_BUILD_TYPE}
		COMMENT
            "Switch CMAKE_BUILD_TYPE to Debug. Building debug application"
	)
endif()

if(NOT TARGET ${PROJECT_NAME}-coverage)
    add_custom_target(${PROJECT_NAME}-coverage
        COMMAND
            ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=coverage ${CMAKE_SOURCE_DIR}
        WORKING_DIRECTORY
            ${CMAKE_SOURCE_DIR}/build-${CMAKE_BUILD_TYPE} #${PROJECT_SOURCE_DIR} vs ${CMAKE_SOURCE_DIR}
        COMMAND
            ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target all WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build-${CMAKE_BUILD_TYPE}
        COMMENT
            "Switch CMAKE_BUILD_TYPE to Test Coverage. Building Coverage application"
    )
endif()

if(NOT TARGET ${PROJECT_NAME}-profiling)
    add_custom_target(${PROJECT_NAME}-profiling
        COMMAND
			${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=profiling ${CMAKE_SOURCE_DIR}
		WORKING_DIRECTORY
			${CMAKE_SOURCE_DIR}/build-${CMAKE_BUILD_TYPE} #${PROJECT_SOURCE_DIR} vs ${CMAKE_SOURCE_DIR}
        COMMAND
			${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target all WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build-${CMAKE_BUILD_TYPE}
        COMMENT
			"Switch CMAKE_BUILD_TYPE to Profiling. Profiling application"
    )
endif()


if(NOT TARGET configure)
    add_custom_target(configure
        COMMENT "Initialize build state, e.g. set properties or create directories"
    )
endif()

if(NOT TARGET compile)
    add_custom_target(compile
        COMMENT "Compile the source code of the project."
#        DEPENDS
#            configure
    )
endif()

if(NOT TARGET test-compile)
    add_custom_target(test-compile
        COMMENT "Compile the test source code into the test destination directory."
#        DEPENDS
#            compile
    )
endif()

if(NOT TARGET unit-test)
    add_custom_target(unit-test
        COMMENT "Run tests using a suitable unit testing framework. These tests should not require the code be packaged or deployed."
#        DEPENDS
#            test-compile
    )
endif()

if(NOT TARGET target-package)
    add_custom_target(target-package
        COMMENT "Take the compiled code and package it in its distributable format, such as a tar.gz."
#        DEPENDS
#            unit-test
    )
endif()

if(NOT TARGET feature-test)
    add_custom_target(feature-test
        COMMENT "Process and deploy the package if necessary into an environment where integration tests can be run."
#      DEPENDS
#            target-package
    )
endif()

if(NOT TARGET verify)
    add_custom_target(verify all
        COMMENT "Rrun any checks to verify the package is valid and meets quality criteria."
#        DEPENDS
#            feature-test
    )
endif()

if(NOT TARGET target-install)
    add_custom_target(target-install
        COMMENT "Install the package into the local repository, for use as a dependency in other projects locally."
    )
endif()

if(NOT TARGET deploy)
    add_custom_target(deploy
        COMMENT "Integration or release environment, copies the final package to the remote repository for sharing with other developers and projects."
    )
endif()

if(NOT TARGET site)
    add_custom_target(site
        COMMENT "Generate the project's site documentation."
    )
endif()

if(NOT TARGET target-clean)
    add_custom_target(target-clean
        COMMENT "Remove all files generated by the previous build."
    )
endif()




add_custom_target (distclean
    # COMMAND rm -vf ${CMAKE_SOURCE_DIR}/*.log
    # COMMAND rm -vf ${CMAKE_SOURCE_DIR}/Makefile
    # COMMAND rm -vf ${CMAKE_SOURCE_DIR}/install_manifest.txt
    # COMMAND rm -vf ${CMAKE_SOURCE_DIR}/cmake_install.cmake
    # COMMAND find ${CMAKE_SOURCE_DIR} -type f -name CMakeCache.txt | xargs -r rm -vf
    # COMMAND find ${CMAKE_SOURCE_DIR} -type d -name CMakeFiles | xargs -r rm -rvf
    # COMMAND find ${CMAKE_SOURCE_DIR} -type f -name "*.marks" | xargs -r rm -vf
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target clean
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target rmdotdiles
    COMMAND ${CMAKE_COMMAND} -E remove_directory CMakeFiles
	COMMAND ${CMAKE_COMMAND} -E remove CMakeCache.txt cmake_install.cmake Makefile
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
	COMMENT "Cleaning target"
)
