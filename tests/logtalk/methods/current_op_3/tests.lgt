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


% plain Prolog database for testing calls in the "user" pseudo-object

:- op(777, yfx, my_test_op).


:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 1.3,
		author is 'Paulo Moura',
		date is 2016/02/16,
		comment is 'Unit tests for the current_op/3 built-in directive.'
	]).

	throws(current_op_3_1, error(type_error(integer,a), logtalk(This::current_op(a,_,_),user))) :-
		this(This),
		{This::current_op(a, _, _)}.

	throws(current_op_3_2, error(domain_error(operator_priority,3000), logtalk(This::current_op(3000,_,_),user))) :-
		this(This),
		{This::current_op(3000, _, _)}.

	throws(current_op_3_3, error(type_error(atom,1), logtalk(This::current_op(_,1,_),user))) :-
		this(This),
		{This::current_op(_, 1, _)}.

	throws(current_op_3_4, error(domain_error(operator_specifier,a), logtalk(This::current_op(_,a,_),user))) :-
		this(This),
		{This::current_op(_, a, _)}.

	throws(current_op_3_5, error(type_error(atom,1), logtalk(This::current_op(_,_,1),user))) :-
		this(This),
		{This::current_op(_, _, 1)}.

	throws(current_op_3_6, error(instantiation_error, logtalk(_::current_op(_,_,_),test_object_1))) :-
		{test_object_1::ie(_)}.

	throws(current_op_3_7, error(type_error(object_identifier, 1), logtalk(1::current_op(_,_,_),test_object_1))) :-
		{test_object_1::te}.

	succeeds(current_op_3_8) :-
		setof(Operator, test_object_1<<current_op(501, xfx, Operator), Operators),
		Operators == [abc, def, ghi].

	succeeds(current_op_3_9) :-
		setof(Operator, test_object_1::current_op(501, xfx, Operator), Operators),
		Operators == [abc].

	succeeds(current_op_3_10) :-
		test_object_1::current_op(600, xfx, (:)),
		\+ test_object_1::current_op(600, xfy, (:)).

	succeeds(current_op_3_11) :-
		\+ test_object_2::current_op(600, xfx, (:)).

	succeeds(current_op_3_12) :-
		test_object_1::operators(Operators),
		Operators == [abc, def, ghi].

	succeeds(current_op_3_13) :-
		test_object_2::operators(Operators),
		Operators == [opq, rst].

	% tests for the "user" pseudo-object

	succeeds(current_op_3_14) :-
		user::current_op(Priority, Associativity, my_test_op),
		Priority == 777, Associativity == yfx.

	succeeds(current_op_3_15) :-
		user::current_op(Priority, Associativity, Operator),
		Priority == 777, Associativity == yfx, Operator == (my_test_op).

	succeeds(current_op_3_16) :-
		% ensure that the unification is not optimized away
		user_object(Object),
		Object::current_op(Priority, Associativity, my_test_op),
		Priority == 777, Associativity == yfx.

	succeeds(current_op_3_17) :-
		% ensure that the unification is not optimized away
		user_object(Object),
		Object::current_op(Priority, Associativity, Operator),
		Priority == 777, Associativity == yfx, Operator == (my_test_op).

	% test semantics for local calls from multifile predicate clauses

	succeeds(current_op_3_18) :-
		primary::p(Priority, Associativity, op_public),
		Priority == 601, Associativity == xfx.

	succeeds(current_op_3_19) :-
		primary::p(Priority, Associativity, op_protected),
		Priority == 601, Associativity == xfx.

	succeeds(current_op_3_20) :-
		primary::p(Priority, Associativity, op_private),
		Priority == 601, Associativity == xfx.

	succeeds(current_op_3_21) :-
		\+ primary::p(_, _, op_local).

	% auxiliary predicates

	user_object(user).

:- end_object.
