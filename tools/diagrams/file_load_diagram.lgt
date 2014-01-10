%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This file is part of Logtalk <http://logtalk.org/>  
%  Copyright (c) 1998-2014 Paulo Moura <pmoura@logtalk.org>
%
%  This program is free software: you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation, either version 3 of the License, or
%  (at your option) any later version.
%  
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%  
%  You should have received a copy of the GNU General Public License
%  along with this program.  If not, see <http://www.gnu.org/licenses/>.
%  
%  Additional licensing terms apply per Section 7 of the GNU General
%  Public License 3. Consult the `LICENSE.txt` file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(file_load_diagram(Format),
	imports(file_diagram(Format))).

	:- info([
		version is 2.0,
		author is 'Paulo Moura',
		date is 2014/01/09,
		comment is 'Predicates for generating file loading dependency diagrams.',
		parnames is ['Format']
	]).

	output_file(Path, Basename, Directory, Options) :-
		^^linking_options(Path, Options, LinkingOptions),
		(	member(directory_paths(true), Options) ->
			member(omit_path_prefix(Prefix), Options),
			(	atom_concat(Prefix, Relative, Directory) ->
				^^output_node(Path, Basename, [Relative], file, LinkingOptions)
			;	^^output_node(Path, Basename, [Directory], file, LinkingOptions)
			)
		;	^^output_node(Path, Basename, [], file, LinkingOptions)
		),
		^^remember_included_file(Path),
		fail.
	output_file(Path, _, _, Options) :-
		logtalk::loaded_file_property(Other, parent(Path)),
		^^remember_referenced_logtalk_file(Other),
		^^save_edge(Path, Other, [loads], loads_file, [tooltip(loads)| Options]),
		fail.
	output_file(Path, _, _, Options) :-
		prolog_modules_diagram_support::source_file_property(Other, parent(Path)),
		^^remember_referenced_prolog_file(Other),
		^^save_edge(Path, Other, [loads], loads_file, [tooltip(loads)| Options]),
		fail.
	output_file(_, _, _, _).

	% by default, don't generate cluster URLs:
	default_option(url_protocol('')).
	% by default, don't omit a path prefix when printing paths:
	default_option(omit_path_prefix('')).
	% by default, don't print directory paths:
	default_option(directory_paths(false)).
	% by default, print current date:
	default_option(date(true)).
	% by default, print relation labels:
	default_option(relation_labels(true)).
	% by default, write diagram to the current directory:
	default_option(output_directory('./')).
	% by default, don't exclude any source files:
	default_option(exclude_files([])).
	% by default, don't exclude any library sub-directories:
	default_option(exclude_libraries([])).

	diagram_name_suffix('_file_load_diagram').

	member(Option, [Option| _]) :-
		!.
	member(Option, [_| Options]) :-
		member(Option, Options).

:- end_object.



:- object(file_load_diagram,
	extends(file_load_diagram(dot))).

	:- info([
		version is 2.0,
		author is 'Paulo Moura',
		date is 2014/01/08,
		comment is 'Predicates for generating file loading dependency diagrams in DOT format.'
	]).

:- end_object.