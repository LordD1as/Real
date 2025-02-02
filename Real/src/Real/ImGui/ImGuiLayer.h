#pragma once

#include "Real/Layer.h"
#include "Real/Events/MouseEvent.h"
#include "Real/Events/KeyEvent.h"
#include "Real/Events/ApplicationEvent.h"

namespace Real
{
	class REAL_API ImGuiLayer : public Layer
	{
	public:
		ImGuiLayer();
		~ImGuiLayer();

		virtual void OnAttach() override;
		virtual void OnDetach() override;
		virtual void OnImGuiRender() override;

		void Begin();
		void End();

	private:
		float m_Time = 0.0f;
	};
}
