%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of Logtalk <http://logtalk.org/>  
%  Copyright 1998-2016 Paulo Moura <pmoura@logtalk.org>
%  
%  Licensed under the Apache License, Version 2.0 (the "License");
%  you may not use this file except in compliance with the License.
%  You may obtain a copy of the License at
%  
%      http://www.apache.org/licenses/LICENSE-2.0
%  
%  Unless required by applicable law or agreed to in writing, software
%  distributed under the License is distributed on an "AS IS" BASIS,
%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%  See the License for the specific language governing permissions and
%  limitations under the License.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 1.0,
		author is 'Paulo Moura',
		date is 2016/06/10,
		comment is 'Unit tests for the threaded_engine_create/3 built-in predicate.'
	]).

	:- threaded.

	% goal argument must be bound at runtime (but no error at compile time)
	throws(threaded_engine_create_3_01, error(instantiation_error, logtalk(threaded_engine_create(_,_,_), This))) :-
		this(This),
		threaded_engine_create(_, _, _).

	% goal argument must be a callable term at runtime
	throws(threaded_engine_create_3_02, error(type_error(callable,1), logtalk(threaded_engine_create(_,1,_), This))) :-
		this(This),
		Goal = 1,	% delay error to runtime
		threaded_engine_create(_, Goal, _).

	% engine names must be unique
	throws(threaded_engine_create_3_03, error(permission_error(create,engine,test_engine_1), logtalk(threaded_engine_create(none,true,test_engine_1), This))) :-
		this(This),
		threaded_engine_create(none, true, test_engine_1),
		threaded_engine_create(none, true, test_engine_1).

	% engine name must be generated when not given
	succeeds(threaded_engine_create_3_04) :-
		threaded_engine_create(none, true, Engine),
		nonvar(Engine).

:- end_object.
