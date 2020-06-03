# p2e
PHP to Erlang simple bridge

## build

1. phpize
1. ./configure --with-erlang=*path to erl_interface*
1. make
1. make install

## prerequisites

You need a working copy of erlang installed, the only one tested so far is OTP/23.
PHP 7.3 must be installed with all the develop versions