#ifndef CFS_DEV_TOOLS_DUMMYTEST_HPP
#define CFS_DEV_TOOLS_DUMMYTEST_HPP

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <boost/shared_ptr.hpp>
#include <cfs/dev/tools/Dummy.hpp>
#include <log4cxx/logger.h>

namespace cfs::dev::tools::test
{
class DummyTest : public ::testing::Test
{

    public:
	DummyTest(); 
        DummyTest(const DummyTest&) = default;
        DummyTest(DummyTest&&) = default;
        DummyTest& operator=(const DummyTest&) = default;
        DummyTest& operator=(DummyTest&&) = default;
        virtual ~DummyTest();

        virtual void SetUp ();
        virtual void TearDown ();

    protected:

	cpp101::Dummy * dummy;
	static log4cxx::LoggerPtr logger;

    private:
        //boost::shared_ptr<Dummy> dummy;
};
}
#endif
