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
		//RE_INFO("ExampleLayer::Update");
	}

	void OnEvent(Real::Event& event) override
	{
		//RE_TRACE("{0}", event.ToString());
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