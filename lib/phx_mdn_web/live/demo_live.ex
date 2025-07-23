defmodule PhxMdnWeb.DemoLive do
  use PhxMdnWeb, :live_view
  alias Phoenix.LiveView.ColocatedHook

  def mount(_params, _session, socket) do
    {:ok, assign(socket, counter: 0)}
  end

  def handle_event("increment", _params, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto p-8">
      <h1 class="text-3xl font-bold mb-4">Colocated Hook Demo</h1>

      <div class="mb-8">
        <h2 class="text-xl font-semibold mb-2">Phone Number Input</h2>
        <input
          id="phone-input"
          type="text"
          phx-hook=".PhoneNumber"
          placeholder="Enter phone number"
          class="input input-bordered w-full max-w-xs"
        />
        <script :type={ColocatedHook} name=".PhoneNumber">
          export default {
            mounted() {
              this.el.addEventListener("input", e => {
                let match = this.el.value.replace(/\D/g, "").match(/^(\d{3})(\d{3})(\d{4})$/)
                if(match) {
                  this.el.value = `${match[1]}-${match[2]}-${match[3]}`
                }
              })
            }
          }
        </script>
      </div>

      <div class="mb-8">
        <h2 class="text-xl font-semibold mb-2">Click Counter with Animation</h2>
        <button
          id="animated-button"
          phx-click="increment"
          phx-hook=".AnimatedButton"
          class="btn btn-primary"
        >
          Clicked: {@counter} times
        </button>
        <script :type={ColocatedHook} name=".AnimatedButton">
          export default {
            mounted() {
              this.el.addEventListener("click", () => {
                this.el.classList.add("animate-bounce")
                setTimeout(() => {
                  this.el.classList.remove("animate-bounce")
                }, 500)
              })
            }
          }
        </script>
      </div>

      <div class="mb-8">
        <h2 class="text-xl font-semibold mb-2">Console Logger</h2>
        <div id="logger-div" phx-hook=".Logger" class="p-4 bg-gray-100 rounded">
          This element logs to console when mounted/updated
        </div>
        <script :type={ColocatedHook} name=".Logger">
          export default {
            mounted() {
              console.log("Logger hook mounted!", this.el)
            },
            updated() {
              console.log("Logger hook updated!")
            },
            destroyed() {
              console.log("Logger hook destroyed!")
            }
          }
        </script>
      </div>
    </div>
    """
  end
end
