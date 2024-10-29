#!/bin/sh
cc -o testblit -O blit.S testblit.c
hyperfine -L arg plain,rel,dmb,dmb2,dmb4,dmb5 --warmup 2 './testblit {arg}'
