#include <Real.h>

class Sandbox : public Real::Application
{
public:
	Sandbox()
	{
	
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