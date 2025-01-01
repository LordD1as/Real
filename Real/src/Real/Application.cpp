#include "repch.h"
#include "Application.h"

#include "Real/Events/ApplicationEvent.h"

namespace Real
{
	Application::Application()
	{
		m_Window = std::unique_ptr<Window>(Window::Create());
	}

	Application::~Application()
	{
	}

	void Application::Run()
	{
		while (m_Running)
		{
			m_Window->OnUpdate();
		}
	}
}