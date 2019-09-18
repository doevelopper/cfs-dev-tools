
#include <cfs/dev/tools/Error.hpp>

const char* Error::name() const noexcept
{
  return "Error ";
}

std::string Error::message(int code) const
{
    switch(auto ec = static_cast<Error::Code>(code); ec)
    {
        case SUCCESS:
            return "success";
        break;

        case TASKFLOW:
            return "taskflow error";
        break;

        case EXECUTOR:
            return "executor error";
        break;

        default:
            return "unknown";
        break;
  };

}
