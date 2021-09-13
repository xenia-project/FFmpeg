#if defined(WIN32) || defined(_WIN32)
#include "config_windows_x86_64.h"
#elif defined(__gnu_linux__)
#include "config_linux_x86_64.h"
#elif defined(__ANDROID__)
#if defined(__aarch64__)
#include "config_android_aarch64.h"
#elif defined(__amd64__)
#include "config_android_x86_64.h"
#elif
#error "android arch unsupported"
#endif
#else
#error "no config"
#endif
