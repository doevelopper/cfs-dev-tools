
#include <iostream>
#include <sstream>
#include <exception>
#include <system_error>

namespace cfs::dev::tools
{
    class Error : public std::error_category
    {
        /*!
         * @enum Code
         * @brief Error code definition.
         */
        enum class Code : std::uint8_t
        {
             SUCCESS = 0
        };

    public:
        /*!
         * @brief Returns the name of the error category
         */
        const char* name() const noexcept override final;
        /*!
         * @brief Acquires the singleton instance of the error category
         */
        static const std::error_category& get();
        /*!
         * @brief Query the human-readable string of each error code.
         */
        std::string message(int) const override final;
    };

    std::error_code make_error_code(Error::Code e)
    {
        return std::error_code(static_cast<int>(e), Error::get());
    }

    // Throws the system error under a given error code.
    template <typename... ArgsT>
    void throw_se(const char* msg, const std::size_t line, Error::Code c, ArgsT&&... args)
    {
        std::ostringstream oss;
        oss << "[" << msg << ":" << line << "] ";
        (oss << ... << args);
        throw std::system_error(c, oss.str());
    }
}

// Register for implicit conversion
namespace std
{
  template <>
  struct is_error_code_enum<cfs::dev::tools::Error::Code> : true_type {};
}

