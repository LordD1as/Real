#pragma once

#ifdef RE_PLATFORM_WINDOW

// It goes from SandboxApp.cpp - extern = look to different translation unit
extern Real::Application* Real::CreateApplication();

int main(int argc, char** argv)
{
	Real::Log::InitLog();

	auto app = Real::CreateApplication();
	app->Run();
	delete app;
}

#endif // RE_PLATFORM_WINDOW