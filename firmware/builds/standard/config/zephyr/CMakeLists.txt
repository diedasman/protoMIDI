if(CONFIG_SHIELD_PROTOMIDI)
  zephyr_library()
  zephyr_library_sources(${CMAKE_CURRENT_LIST_DIR}/../boards/shields/protomidi/running_leds.c)
endif()
