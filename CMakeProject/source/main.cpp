#include <spdlog/spdlog.h>

int main(int argc, char* argv[]) {
	auto console = spdlog::stdout_color_mt("console");
  console->info("Hello World!");
        
  if (argc) {
  	console->info("Arg count {}", argc);
    for(int i = 0; i < argc; ++i) {
    	console->info("Arg {0}: {1}", i, argv[i]);          
    }
  }
  return 0;
}