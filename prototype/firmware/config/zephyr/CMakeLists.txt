if(CONFIG_SHIELD_PROTOMIDI AND CONFIG_ZMK_DISPLAY_STATUS_SCREEN_CUSTOM)
  zephyr_library()
  zephyr_library_sources(${CMAKE_CURRENT_LIST_DIR}/../boards/shields/protomidi/custom_status_screen.c)
endif()
