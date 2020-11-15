#ifndef CFS_DEV_TOOLS_DUMMY_HPP
#define CFS_DEV_TOOLS_DUMMY_HPP

#include <log4cxx/logger.h>

namespace cfs::dev::tools
{
/*!
 * @brief The Dummy class used as walking Skeleton class for the unit, spec and feature tests of the template
 */
class Dummy
{

static log4cxx::LoggerPtr logger;

public:

Dummy();
/*!
 * @brief Dummy who knows how to say hello world
 * @param hello_string 'Hello' in my language
 * @param world_string 'World' in my language
 */
Dummy (const std::string& hello_string, const std::string& world_string);
Dummy(const Dummy&) = default;
Dummy(Dummy&&) = default;
Dummy& operator=(const Dummy&) = default;
Dummy& operator=(Dummy&&) = default;
virtual ~Dummy();

std::string speak() const;
bool speechless() const;

private:
std::string m_hello{};
std::string m_world{};
bool m_speechless {true};
};
}
#endif
