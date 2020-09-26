# Makefile Examples

This is a collection of example makefiles with documentation and comments interspersed,
liberally. Output from execution is included as well.

## Major Acknowledgements, References and Code Borrowing

### [Tutorial Page](https://makefiletutorial.com)

The page linked above was a great help in getting me started with Make. I relied heavily on it,
particularly early on, both for understanding and for example code. In some cases I may
have copied text or code verbatim. I'll try to give credit with a link in each of the
files that it contributed to, no matter how small the contribution.

### [GNU Make Online Guide (Current Version)](https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents)

A guide for the latest and greatest version of GNU Make. I'll try to link to relevant topic
pages in each example file, at least the first time that I'm discussing a feature. I may
copy code and text verbatim, sometimes.

### Creation of the Tutorials/Examples

Again, I may copy code and text verbatim, sometimes. Other times, I may have taken and
tweaked something from sources. My intent is not to plagiarize, only to gather. I started
creating these files as practice for my own learning and included comments for my own
reference. In the process, I sometimes found guide pages to lack sufficient examples or
provide examples that I just didn't like. Other times I discovered, through my own
muddling (sometimes followed by a Google search), behaviors that I felt weren't called out
well by the guide. The makefile_parsing tutorial comes to mind, especially. I decided that
these files might be useful to others. I apologize for any errors, poor paraphrasing, poor
summarizing or poor tweaking and any omission of credit. I also encourage any readers to
check out the links as they are great sources for learning.

## [Feature Changes](https://lists.gnu.org/archive/cgi-bin/namazu.cgi?query=GNU+make&submit=Search!&idxname=info-gnu)

I used GNU Make 4.3 when creating these files (at least after I realized how old my version of
Make was). Having said that, some users may find themselves tied to older versions that
don't have all of the newer features. To account for that, I try to note what release newer
features were added in. I only go as far back as GNU Make 3.82; older releases don't seem
to have detailed release notes. I assume that anything not noted in the 3.82+ release notes
is supported in 3.81. For even earlier versions, you'll have to check the version's reference
guide.

## Function Tutorials

For the function tutorials, the goal for the output was to display the function calls
in addition to their results. To keep the code short and readable, calls were placed
recursive variables. In real-world use-cases, you probably wouldn't do this because of the
performance cost.

## Execution

An installation of Make, preferably GNU Make, is needed to run the examples, though the
output is already provided. On Linux, you can install Make through the system package
manager. On Windows, use [Cygwin](https://cygwin.com/install.html) or the
[WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10). On Mac, try
[this](https://stackoverflow.com/a/10265766). Readers are encouraged to play with
the examples and even write their own files to enhance their learning.

## The Makefiles

Not all files have example code. A couple are just overviews of topics, for the moment. Example
code may be added in the future.

All example files are named *.mak. To avoid splitting them into individual folders,
they were given unique names specifying what topic they covered followed by a common
extension. As a convenience, a Makefile is included which will allow you to run any example file
with tut_#. To build a specific target in an example use tut_#_\<target\>. Commandline options
will automatically be passed on to the example .mak.

Examples:  
$ make tut_01  
$ make tut_01_clean
