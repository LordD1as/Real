#pragma once

#ifdef RE_PLATFORM_WINDOW

extern Real::Application* Real::CreateApplication();

int main(int argc, char** argv)
{
	auto app = Real::CreateApplication();
	app->Run();
	delete app;
}

#endif // RE_PLATFORM_WINDOW