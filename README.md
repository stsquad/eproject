Eproject is an extension that lets you group related files together as
projects. It aims to be as unobtrusive as possible. No new files are
created (or required to exist) on disk, and buffers that aren't a
member of a project are not affected in any way.

Usage
=====

The main starting point for eproject is defining project types.
There is a macro for this, define-project-type, that accepts four
arguments, the type name (a symbol), a list of supertypes (for
inheriting properties), a form that is executed to determine
whether a file is a member of a project, and then a free-form
property list.  An example will clear things up:

    (define-project-type kernel
      (generic-git)
      (look-for "Documentation/CodingStyle")
      :c-style "linux-tabs-style"
      :common-compiles (my-kernel-compile-strings "make" "make gtags" "make TAGS"))


