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
		date is 2012/11/19,
		comment is 'Unit tests for the threaded_peek/1-2 built-in predicate.'
	]).

	throws(threaded_peek_1_1, error(instantiation_error, logtalk(threaded_peek(_), _))) :-
		{threaded_peek(_)}.

	throws(threaded_peek_1_2, error(type_error(callable, 1), logtalk(threaded_peek(_), _))) :-
		{threaded_peek(1)}.

	throws(threaded_peek_2_1, error(instantiation_error, logtalk(threaded_peek(_,_), _))) :-
		{threaded_peek(_, _)}.

	throws(threaded_peek_2_2, error(type_error(callable, 1), logtalk(threaded_peek(_,_), _))) :-
		{threaded_peek(1, _)}.

	throws(threaded_peek_2_3, error(instantiation_error, logtalk(threaded_peek(_,_), _))) :-
		{threaded_peek(true, _)}.

	succeeds(threaded_peek_2_4) :-
		{threaded_call(true, Tag),
		 thread_sleep(1),
		 threaded_peek(true, Tag)}.

:- end_object.
