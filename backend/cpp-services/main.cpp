#include <iostream>
#include <thread>
#include <chrono>

int main() {
    std::cout << "C++ Service iniciado correctamente" << std::endl;

    // Simular servicio ejecutandose
    while (true) {
        std::cout << "Servicio funcionando... "
                  << std::chrono::system_clock::now().time_since_epoch().count()
                  << std::endl;
        std::this_thread::sleep_for(std::chrono::seconds(30));
    }

    return 0;
}
