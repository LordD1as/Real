#include "repch.h"
#include "Log.h"

#include "spdlog/sinks/stdout_color_sinks.h"

namespace Real
{
	// Since it is 'static' (means it is translated just for one translation unit, where it is - Log.h),
	// we have to defined also here, otherwise it will not link
	std::shared_ptr<spdlog::logger> Log::s_CoreLogger;
	std::shared_ptr<spdlog::logger> Log::s_ClientLogger;

	void Log::InitLog()
	{
		spdlog::set_pattern("%^[%T] %n: %v%$");
		s_CoreLogger = spdlog::stdout_color_mt("REAL");
		s_CoreLogger->set_level(spdlog::level::trace);

		s_ClientLogger = spdlog::stdout_color_mt("APP");
		s_ClientLogger->set_level(spdlog::level::trace);
	}
}
