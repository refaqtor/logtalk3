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


% avoid a clash with the "block" operaror defined in SICStus Prolog and YAP
:- if(current_op(1150, fx, block)).
	:- op(0, fx, block).
:- endif.


:- initialization((
	logtalk_load(library(basic_types_loader)),
	logtalk_load(library(metapredicates_loader)),
	logtalk_load(roots(loader)),
	% compile messages with event support and turn event support on in order to 
	% both use the "stack_monitor" monitor for visualizing stack changes and to
	% allow the constrained relation "block_stack" to perform its magic:
	logtalk_load(blocks, [events(allow)]),
	set_logtalk_flag(events, allow)
)).
