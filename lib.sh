#!/bin/bash

# alr exec -- gcc obj/development/nif_bootstrap.o obj/development/erlang_nifs.o obj/development/erlang_nifsmain.o obj/development/erlang_nifs_config.o obj/development/erlang_nifs-arity_1.o obj/development/testing.o  -bundle -bundle_loader /usr/local/Cellar/erlang/26.0.2/lib/erlang/erts-14.0.2/bin/beam.smp -L/users/andy/.config/alire/cache/dependencies/gnat_native_12.2.1_77267eb1/lib/gcc/x86_64-apple-darwin19.6.0/12.2.0/adalib/ /users/andy/.config/alire/cache/dependencies/gnat_native_12.2.1_77267eb1/lib/gcc/x86_64-apple-darwin19.6.0/12.2.0/adalib/libgnat.a -o lib/niftest.so


# alr exec -- gcc lib/libErlang_Nifs.a -bundle -bundle_loader /usr/local/lib/erlang/erts-14.0.2/bin/beam.smp -o lib/niftest.so

#alr exec -- gcc lib/libErlang_Nifs.a  -bundle -bundle_loader /usr/local/lib/erlang/erts-14.0.2/bin/beam.smp -L/users/andy/.config/alire/cache/dependencies/gnat_native_12.2.1_77267eb1/lib/gcc/x86_64-apple-darwin19.6.0/12.2.0/adalib/ /users/andy/.config/alire/cache/dependencies/gnat_native_12.2.1_77267eb1/lib/gcc/x86_64-apple-darwin19.6.0/12.2.0/adalib/libgnat.a -o lib/niftest.so

#alr exec -- gcc obj/development/nif_bootstrap.o -lc++ -bundle -bundle_loader /usr/local/lib/erlang/erts-14.0.2/bin/beam.smp -o lib/niftest.so

#   -L${GNAT_NATIVE_ALIRE_PREFIX}/lib/gcc/x86_64-apple-darwin19.6.0/12.2.0/adalib/ \
#   ${GNAT_NATIVE_ALIRE_PREFIX}/lib/gcc/x86_64-apple-darwin19.6.0/12.2.0/adalib/libgnat.a \

GNATLIBDIR=`dirname \`alr exec -- gcc --print-libgcc\``

alr exec -- g++ \
  lib/libErlang_Nifs.a \
  obj/development/b__erlang_nifs.o \
  obj/development/erlang_nifs-arity_1.o \
  obj/development/erlang_nifs.o \
  obj/development/my_nifs.o \
  obj/development/nif_bootstrap.o \
  -L${GNATLIBDIR} \
  ${GNATLIBDIR}/adalib/libgnat.a \
  -bundle \
  -bundle_loader /usr/local/lib/erlang/erts-14.0.2/bin/beam.smp \
  -o lib/niftest.so
