#ifndef CFS_DEV_TOOLS_UTILS_RESULT_HPP
#define CFS_DEV_TOOLS_UTILS_RESULT_HPP
#include <string>

namespace cfs::dev::tools::utils
{
	/*!
	 * Example Usage:
	 * 	return Result<bool> success{true};
	 * 	or in case of a failure
	 * 	return Result<bool> failure{false, error};
	 */
	template<typename T>
	struct Result
	{
	   const T result;
	   const std::string error;

	   /*!
		* @brief Result of an operation.
		* @param output whatever the expected output would be
		* @param err error message to the client, default is empty which means successful operation
		*/
	   Result(T output, const std::string& err)
	   : result{output}
	   , error{err}
	   {
	   }

	   Result(T output)
	   : result{output}
	   , error{""}
	   {
	   }

	   Result() = delete;
	   Result(const Result&) = default;
	   Result(Result&&) = default;
	   Result& operator=(const Result&) & = default;
	   Result& operator=(Result&&) & = default;
	   ~Result() = default;

	   /*!
	    * @return status whether or not the Result contains a failure
		*/
	   bool failed() const
	   {
		  return (!error.empty());
	   }

	   /// convenience function @return status whether or not the Result was a success
	   bool success() const
	   {
		  return (error.empty());
	   }

	};
}
#endif

