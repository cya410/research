include_directories(..)

set(LSAN_CFLAGS ${SANITIZER_COMMON_CFLAGS})
append_no_rtti_flag(LSAN_CFLAGS)

set(LSAN_COMMON_SOURCES
  lsan_common.cc
  lsan_common_linux.cc)

set(LSAN_SOURCES
  lsan.cc
  lsan_allocator.cc
  lsan_interceptors.cc
  lsan_preinit.cc
  lsan_thread.cc)

set(LSAN_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_target(lsan)

if(APPLE)
  foreach(os ${SANITIZER_COMMON_SUPPORTED_DARWIN_OS})
    add_compiler_rt_darwin_object_library(RTLSanCommon ${os}
      ARCH ${LSAN_COMMON_SUPPORTED_ARCH}
      SOURCES ${LSAN_COMMON_SOURCES}
      CFLAGS ${LSAN_CFLAGS})
  endforeach()
elseif(NOT ANDROID)
  foreach(arch ${LSAN_COMMON_SUPPORTED_ARCH})
    add_compiler_rt_object_library(RTLSanCommon ${arch}
      SOURCES ${LSAN_COMMON_SOURCES}
      CFLAGS ${LSAN_CFLAGS})
  endforeach()

  foreach(arch ${LSAN_SUPPORTED_ARCH})
    add_compiler_rt_static_runtime(clang_rt.lsan-${arch} ${arch}
      SOURCES ${LSAN_SOURCES}
              $<TARGET_OBJECTS:RTInterception.${arch}>
              $<TARGET_OBJECTS:RTSanitizerCommon.${arch}>
              $<TARGET_OBJECTS:RTSanitizerCommonLibc.${arch}>
              $<TARGET_OBJECTS:RTLSanCommon.${arch}>
      CFLAGS ${LSAN_CFLAGS})
    add_dependencies(lsan clang_rt.lsan-${arch})
  endforeach()
endif()

add_dependencies(compiler-rt lsan)
