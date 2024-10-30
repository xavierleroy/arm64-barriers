# Performance issues with ARM64 barriers

This is a reproduction case for strange performance issues on Apple Silicon observed with OCaml-generated ARM64 code: https://github.com/ocaml/ocaml/issues/13262

To measure: `sh runtest.sh`

- `plain`: normal store `str`, no barrier
- `rel`: `dmb ishld` barrier, release store `stlr`
- `dmb`: `dmb ishld` barrier, plain store `str`
- `dmb2`: same, unrolled twice
- `dmb4`: same, unrolled 4 times
- `dmb5`: same, unrolled 5 times

## Mac M1

`dmb ishld; str` (plain store) is much slower (like, 50 times slower) than `dmb ishld; stlr` (release store), except if we unroll the loop with the plain store 5 times.

```
Benchmark 1: ./testblit plain
  Time (mean ± σ):      66.3 ms ±   0.1 ms    [User: 65.2 ms, System: 0.7 ms]
  Range (min … max):    66.0 ms …  66.5 ms    43 runs
 
Benchmark 2: ./testblit rel
  Time (mean ± σ):      70.8 ms ±   0.1 ms    [User: 69.7 ms, System: 0.7 ms]
  Range (min … max):    70.6 ms …  71.1 ms    41 runs
 
Benchmark 3: ./testblit dmb
  Time (mean ± σ):      3.089 s ±  0.311 s    [User: 3.077 s, System: 0.011 s]
  Range (min … max):    2.738 s …  3.659 s    10 runs
 
Benchmark 4: ./testblit dmb2
  Time (mean ± σ):      3.269 s ±  0.546 s    [User: 3.257 s, System: 0.011 s]
  Range (min … max):    2.620 s …  4.171 s    10 runs
 
Benchmark 5: ./testblit dmb4
  Time (mean ± σ):      3.633 s ±  0.916 s    [User: 3.619 s, System: 0.014 s]
  Range (min … max):    2.782 s …  4.930 s    10 runs
 
Benchmark 6: ./testblit dmb5
  Time (mean ± σ):      69.7 ms ±   0.3 ms    [User: 68.4 ms, System: 0.8 ms]
  Range (min … max):    69.2 ms …  70.3 ms    41 runs
 
Summary
  ./testblit plain ran
    1.05 ± 0.00 times faster than ./testblit dmb5
    1.07 ± 0.00 times faster than ./testblit rel
   46.62 ± 4.69 times faster than ./testblit dmb
   49.34 ± 8.25 times faster than ./testblit dmb2
   54.84 ± 13.82 times faster than ./testblit dmb4
```

## Raspberry Pi 4

All versions involving barriers are slow: 4 to 12 times slower than the no-barrier code, but not 50 times slower either.  `str` is better than `stlr`.  A bit of unrolling helps.

```
Benchmark 1: ./testblit plain
  Time (mean ± σ):     282.4 ms ±   3.4 ms    [User: 278.0 ms, System: 3.8 ms]
  Range (min … max):   276.4 ms … 287.8 ms    10 runs
 
Benchmark 2: ./testblit rel
  Time (mean ± σ):      3.271 s ±  0.014 s    [User: 3.256 s, System: 0.008 s]
  Range (min … max):    3.254 s …  3.293 s    10 runs
 
Benchmark 3: ./testblit dmb
  Time (mean ± σ):      2.085 s ±  0.017 s    [User: 2.076 s, System: 0.006 s]
  Range (min … max):    2.060 s …  2.108 s    10 runs
 
Benchmark 4: ./testblit dmb2
  Time (mean ± σ):      1.211 s ±  0.039 s    [User: 1.204 s, System: 0.004 s]
  Range (min … max):    1.153 s …  1.245 s    10 runs
 
  Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet PC without any interferences from other programs. It might help to use the '--warmup' or '--prepare' options.
 
Benchmark 5: ./testblit dmb4
  Time (mean ± σ):      1.227 s ±  0.040 s    [User: 1.217 s, System: 0.007 s]
  Range (min … max):    1.175 s …  1.264 s    10 runs
 
Benchmark 6: ./testblit dmb5
  Time (mean ± σ):      1.280 s ±  0.027 s    [User: 1.274 s, System: 0.004 s]
  Range (min … max):    1.263 s …  1.357 s    10 runs
 
  Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet PC without any interferences from other programs. It might help to use the '--warmup' or '--prepare' options.
 
Summary
  './testblit plain' ran
    4.29 ± 0.15 times faster than './testblit dmb2'
    4.34 ± 0.15 times faster than './testblit dmb4'
    4.53 ± 0.11 times faster than './testblit dmb5'
    7.39 ± 0.11 times faster than './testblit dmb'
   11.58 ± 0.15 times faster than './testblit rel'
```

## Ampere eMAG

cfarm185 from gcc compile farm https://portal.cfarm.net/machines/list/

All versions involving barriers are slow: 10 to 13 times slower than the no-barrier code. `strl` is a bit worse.

```
Benchmark 1: ./testblit plain
  Time (mean ± σ):     113.5 ms ±   0.2 ms    [User: 112.3 ms, System: 1.1 ms]
  Range (min … max):   113.2 ms … 113.8 ms    25 runs
 
Benchmark 2: ./testblit rel
  Time (mean ± σ):      1.586 s ±  0.047 s    [User: 1.584 s, System: 0.002 s]
  Range (min … max):    1.541 s …  1.631 s    10 runs
 
Benchmark 3: ./testblit dmb
  Time (mean ± σ):      1.151 s ±  0.047 s    [User: 1.150 s, System: 0.001 s]
  Range (min … max):    1.106 s …  1.197 s    10 runs
 
Benchmark 4: ./testblit dmb2
  Time (mean ± σ):      1.151 s ±  0.047 s    [User: 1.149 s, System: 0.002 s]
  Range (min … max):    1.106 s …  1.197 s    10 runs
 
Benchmark 5: ./testblit dmb4
  Time (mean ± σ):      1.158 s ±  0.047 s    [User: 1.156 s, System: 0.002 s]
  Range (min … max):    1.114 s …  1.204 s    10 runs
 
Benchmark 6: ./testblit dmb5
  Time (mean ± σ):      1.159 s ±  0.047 s    [User: 1.155 s, System: 0.004 s]
  Range (min … max):    1.114 s …  1.204 s    10 runs
 
Summary
  ./testblit plain ran
   10.14 ± 0.42 times faster than ./testblit dmb
   10.14 ± 0.42 times faster than ./testblit dmb2
   10.21 ± 0.41 times faster than ./testblit dmb4
   10.21 ± 0.42 times faster than ./testblit dmb5
   13.97 ± 0.41 times faster than ./testblit rel
```
