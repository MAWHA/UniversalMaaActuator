function(install_agents agent_dir install_dir)
    set(agent_dirs "")
    file(GLOB items ${agent_dir}/*)
    foreach(path ${items})
        if(IS_DIRECTORY ${path})
            list(APPEND agent_dirs ${path})
        endif()
    endforeach()
    if(NOT "${agent_dirs}" STREQUAL "")
        install(DIRECTORY ${agent_dirs} DESTINATION ${install_dir})
    endif()
endfunction()
