#include <fmt/format.h>
#include <vector>

int main(int argc, char* argv[])
{
    fmt::print("hello world!");

    if (argc)
    {
        fmt::print("Arg count {}", argc);
        for(int i = 0; i < argc; ++i) {
            fmt::print("Arg {0}: {1}", i, argv[i]);
        }
    }
    return 0;
}
