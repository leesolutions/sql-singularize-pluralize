//*****************************************************************************
// Copyright © 2007, Steve Abraham
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer. 
//
// Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution. 
//
// Neither the name of the ORGANIZATION nor the names of its contributors may
// be used to endorse or promote products derived from this software without
// specific prior written permission. 
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//*****************************************************************************
using System.Collections;
using System.Data.SqlTypes;
using System.Text.RegularExpressions;
using Microsoft.SqlServer.Server;

namespace SqlClrTools
{
	public sealed class SqlRegEx
	{
		[SqlFunction(DataAccess = DataAccessKind.None, IsDeterministic = true, IsPrecise = true, Name = "ufn_RegExIsMatch", SystemDataAccess = SystemDataAccessKind.None)]
		public static SqlBoolean RegExIsMatch(SqlString input, SqlString pattern, SqlBoolean ignoreCase)
		{
			//If either input is NULL, return NULL
			if (input.IsNull || pattern.IsNull)
			{
				return SqlBoolean.Null;
			}

			//Execute the regular expression and return the result
			return new SqlBoolean(Regex.IsMatch(input.Value, pattern.Value, ignoreCase.Value ? RegexOptions.IgnoreCase : RegexOptions.None));
		}

		[SqlFunction(DataAccess = DataAccessKind.None, IsDeterministic = true, IsPrecise = true, Name = "ufn_RegExReplace", SystemDataAccess = SystemDataAccessKind.None)]
		public static SqlString RegExReplace(SqlString input, SqlString pattern, SqlString replacement, SqlBoolean ignoreCase)
		{
			//If either input is NULL, return NULL
			if (input.IsNull || pattern.IsNull)
			{
				return SqlString.Null;
			}

			//Execute the regular expression and return the result
			return new SqlString(Regex.Replace(input.Value, pattern.Value, replacement.Value, ignoreCase.Value ? RegexOptions.IgnoreCase : RegexOptions.None));
		}

		[SqlFunction(DataAccess = DataAccessKind.None, IsDeterministic = true, IsPrecise = true, Name = "ufn_RegExMatches", SystemDataAccess = SystemDataAccessKind.None, FillRowMethodName = "GetRegExMatches")]
		public static IEnumerable RegExMatches(SqlString input, SqlString pattern, SqlBoolean ignoreCase)
		{
			//If either input is NULL, return NULL
			if (input.IsNull || pattern.IsNull)
			{
				return null;
			}

			//Execute the regular expression and return the result
			return Regex.Matches(input.Value, pattern.Value, ignoreCase.Value ? RegexOptions.IgnoreCase : RegexOptions.None);
		}
		private static void GetRegExMatches(object input, out SqlString match, out SqlInt32 matchIndex, out SqlInt32 matchLength)
		{
			//Get a handle to the match object
			Match RegExMatch = (Match)input;

			//Set the column values
			match = new SqlString(RegExMatch.Value);
			matchIndex = new SqlInt32(RegExMatch.Index);
			matchLength = new SqlInt32(RegExMatch.Length);
		}

		[SqlFunction(DataAccess = DataAccessKind.None, IsDeterministic = true, IsPrecise = true, Name = "ufn_RegExSplit", SystemDataAccess = SystemDataAccessKind.None, FillRowMethodName = "GetRegExSplits")]
		public static IEnumerable RegExSplit(SqlString input, SqlString pattern, SqlBoolean ignoreCase)
		{
			//If either input is NULL, return NULL
			if (input.IsNull || pattern.IsNull)
			{
				return null;
			}

			//Execute the regular expression and return the result
			return Regex.Split(input.Value, pattern.Value, ignoreCase.Value ? RegexOptions.IgnoreCase : RegexOptions.None);
		}
		private static void GetRegExSplits(object input, out SqlString match)
		{
			//Set the match
			match = new SqlString((string)input);
		}

		private SqlRegEx()
		{
			//Since all of the methods in this class are static, there is no need for a public constructor
		}
	}
}