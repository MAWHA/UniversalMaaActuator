# ```
# AppVersion          <major> * 1000000 + <minor> * 1000 + <patch>
# AppVersionNameFull  <major>.<minor> [ .<patch> [ .<alpha>_alpha | _beta ] ]
# AppVersionNameMajor <major>.<minor>
# AppVersionNameSmall <major>.<minor> [ .<patch> ]
# AppVersionStr       <major>.<minor>.<patch>
# AlphaVersion        <alpha>
# BetaChannel         <beta>
# ```

function(desktop_app_parse_version file)
    file(STRINGS ${file} lines)
    foreach(line ${lines})
        string(REPLACE " " ";" parts ${line})
        list(GET parts 0 name)
        if(${name} STREQUAL "AppVersionNameFull")
            list(LENGTH parts length)
            math(EXPR index "${length} - 1")
            list(GET parts ${index} version)
            break()
        endif()
    endforeach()

    if(NOT ${version} MATCHES "[0-9]+\.[0-9]+(\.[0-9]+(\.[0-9]+_alpha|_beta)?)?")
        message(FATAL_ERROR "Bad version: ${version}, check ${file}")
    endif()

    message(STATUS "Version: ${version}")

    string(REPLACE "." ";" components ${version})
    list(POP_BACK components last_component)
    string(REPLACE "_" ";" last_components ${last_component})
    list(APPEND components ${last_components})
    list(LENGTH components components_count)
    list(GET components -1 last_component)

    list(GET components 0 major)
    list(GET components 1 minor)
    string(COMPARE EQUAL ${last_component} "alpha" alpha_channel)
    string(COMPARE EQUAL ${last_component} "beta" beta_channel)
    if(${alpha_channel} STREQUAL 1)
        list(GET components -2 alpha)
    else()
        set(alpha 0)
    endif()
    if(${beta_channel} STREQUAL 1)
        set(beta_bool "true")
    else()
        set(beta_bool "false")
    endif()

    if(${components_count} GREATER 2)
        list(GET components 2 patch)
    else()
        set(patch 0)
    endif()

    math(EXPR version_int "${major} * 1000000 + ${minor} * 1000 + ${patch}")

    set(major_name "${major}.${minor}")
    set(normal_name "${major_name}.${patch}")
    if(${patch} STREQUAL 0)
        set(small_name "${major_name}")
    else()
        set(small_name "${normal_name}")
    endif()

    if(${alpha_channel} STREQUAL 1)
        math(EXPR version_int_alpha "${version_int} * 1000 + ${alpha}")
    else()
        set(version_int_alpha 0)
    endif()

    set(version_dot "${normal_name}.${alpha}")

    set(desktop_app_version_int ${version_int} PARENT_SCOPE)
    set(desktop_app_version_int_alpha ${version_int_alpha} PARENT_SCOPE)
    set(desktop_app_version_name ${normal_name} PARENT_SCOPE)
    set(desktop_app_version_name_small ${small_name} PARENT_SCOPE)
    set(desktop_app_version_name_full ${version} PARENT_SCOPE)
    set(desktop_app_version_beta_bool ${beta_bool} PARENT_SCOPE)
    set(desktop_app_version_cmake ${version_dot} PARENT_SCOPE)
endfunction()
