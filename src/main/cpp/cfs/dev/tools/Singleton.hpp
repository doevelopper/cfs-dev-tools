#ifndef CFS_DEV_TOOLS_SINGLETON_HPP
#define CFS_DEV_TOOLS_SINGLETON_HPP

#include <atomic>
#include <condition_variable>
#include <thread>
#include <mutex>

namespace cfs::dev::tools
{
    template<class Mutex, class Lock = std::unique_lock<Mutex>>
    Lock make_lock(Mutex& mutex)
    {
        return Lock(mutex);
    }
    /*!
     * @brief Curiously recursive base to quickly implement a singleton.
     *
     *     All you have to do is implement a private default constructor
     *     and befriend SuperSingleton.
     */

    template<class Derived>
    class Singleton
    {
    public:

        /*!
         * @brief Returns the singleton instance
         */
        static Derived& instance()
        {
            static Derived singleton;
            return singleton;
        }

    protected:

        using SuperSingleton = Singleton;
        Singleton()
        {
        }

    private:
        Singleton(const Singleton&) = delete;
        Singleton(Singleton&&) = delete;
        Singleton& operator=(const Singleton&) = delete;
        Singleton& operator=(Singleton&&) = delete;
    };

}
#endif

