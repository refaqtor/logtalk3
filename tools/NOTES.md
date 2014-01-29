________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  
Copyright (c) 1998-2014 Paulo Moura <pmoura@logtalk.org>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Additional licensing terms apply per Section 7 of the GNU General
Public License 3. Consult the `LICENSE.txt` file for details.
________________________________________________________________________


This folder contains some useful programming tools. To load all tools,
type:

	| ?- logtalk_load(tools(loader)).

To load a specific tool either change your Prolog working directory
to the tool folder and then compile and load the corresponding loader 
utility file or simply use library notation as argument for the 
compiling and loading predicates. For example:

	| ?- logtalk_load(lgtunit(loader)).

Currently, the following tools are available, each one with its own
`loader.lgt` and `NOTES.md` files:

- assertions
- debugger
- diagrams
- help
- lgtdoc
- lgtunit
- profiler

All source files are formatted using tabs (the recommended setting is a tab
width equivalent to 4 spaces).

Specific notes about each tool can be found in the corresponding `NOTES.md`
files. Basic XHTML documentation about each tool can be found on the `docs`
directory (open the `tools.html` file in your web browser). To regenerate
this documentation, start Logtalk with your favorite back-end Prolog compiler
and follow these steps:

(1) If the `source_data` flag is not `on` by default, type the query:

	| ?- set_logtalk_flag(source_data, on).

(2) Load all the tools using the query:

	| ?- {tools(loader)}.

(3) Generate the XML documenting files for all loaded tools using the query:

	| ?- lgtdoc::rlibrary(tools, [xmldir('$LOGTALKUSER/docs/tmp')]).

(4) Run the command `lgt2html` on the `$LOGTALKUSER/docs/tmp` directory 
to generate (X)HTML documentation or the command `lgt2pdf` to generate
PDF documentation. For example:

	$ cd $LOGTALKUSER/docs/tmp
	$ lgt2html -i tools.html -t "Tools documentation index"

After generating the (X)HTML and/or PDF documentation, you can move the
files to the upper directory, `$LOGTALKUSER/docs`, and delete the temporary
directory.