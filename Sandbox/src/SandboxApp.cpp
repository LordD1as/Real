#include <Real.h>

class ExampleLayer : public Real::Layer
{
public:
	ExampleLayer()
		: Layer("Example")
	{
	}

	void OnUpdate() override
	{
		if (Real::Input::IsKeyPressed(RE_KEY_TAB))
			RE_INFO("Tab key is pressed!");
	}

	void OnEvent(Real::Event& event) override
	{
		if (event.GetEventType() == Real::EventType::KeyPressed)
		{
			Real::KeyPressedEvent& e = (Real::KeyPressedEvent&)event;
			RE_TRACE("{0}", (char)e.GetKeyCode());
		}
	}
};

class Sandbox : public Real::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
		PushOverlay(new Real::ImGuiLayer());
	}

	~Sandbox()
	{
	
	}
};

// Definition in Application.h
Real::Application* Real::CreateApplication()
{
	return new Sandbox();
}