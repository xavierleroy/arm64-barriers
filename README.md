# Performance issues with ARM64 barriers

To measure: `sh runtest.sh`

- `plain`: normal store `str`, no barrier
- `rel`: `dmb ishld` barrier, release store `stlr`
- `dmb`: `dmb ishld` barrier, plain store `str`
- `dmb2`: same, unrolled twice
- `dmb4`: same, unrolled 4 times
- `dmb5`: same, unrolled 5 times

Bottom line: `dmb ishld; str` (plain store) is much slower than `dmb ishld; stlr` (release store), except if we unroll the loop with the plain store 5 times.

## Mac M1

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

