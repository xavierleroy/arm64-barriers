#ifdef __APPLE__
#define G(x) _##x
#else
#define G(x) x
#endif

	.text
	.align	3
        .global G(blit_dmb)
G(blit_dmb):
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_adjust_cfa_offset	16
	.cfi_offset 30, -8
	str	x30, [sp, #8]
L140:
        add     x2, x2, x2
        add     x2, x2, #1
	orr	x5, xzr, #1
L139:
	cmp	x5, x2
	b.ge	L138
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	ldr	x16, [x3, #0]
	cmp	x4, x16
	b.hi	L139
L138:
	orr	x0, xzr, #1
	ldr	x30, [sp, #8]
	add	sp, sp, #16
	.cfi_adjust_cfa_offset	-16
	ret
	.cfi_endproc

	.text
	.align	3
        .global G(blit_rel)
G(blit_rel):
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_adjust_cfa_offset	16
	.cfi_offset 30, -8
	str	x30, [sp, #8]
L540:
        add     x2, x2, x2
        add     x2, x2, #1
	orr	x5, xzr, #1
L539:
	cmp	x5, x2
	b.ge	L538
	add	x7, x1, x5, lsl #2
        sub     x7, x7, #4
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	stlr	x9, [x7, 0]
	add	x5, x5, #2
	ldr	x16, [x3, #0]
	cmp	x4, x16
	b.hi	L539
L538:
	orr	x0, xzr, #1
	ldr	x30, [sp, #8]
	add	sp, sp, #16
	.cfi_adjust_cfa_offset	-16
	ret
	.cfi_endproc

	.text
	.align	3
        .global G(blit_plain)
G(blit_plain):
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_adjust_cfa_offset	16
	.cfi_offset 30, -8
	str	x30, [sp, #8]
L240:
        add     x2, x2, x2
        add     x2, x2, #1
	orr	x5, xzr, #1
L239:
	cmp	x5, x2
	b.ge	L238
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	str	x9, [x7, #-4]
	add	x5, x5, #2
	ldr	x16, [x3, #0]
	cmp	x4, x16
	b.hi	L239
L238:
	orr	x0, xzr, #1
	ldr	x30, [sp, #8]
	add	sp, sp, #16
	.cfi_adjust_cfa_offset	-16
	ret
	.cfi_endproc

	.text
	.align	3
        .global G(blit_dmb_2)
G(blit_dmb_2):
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_adjust_cfa_offset	16
	.cfi_offset 30, -8
	str	x30, [sp, #8]
L340:
        add     x2, x2, x2
        add     x2, x2, #1
	orr	x5, xzr, #1
L339:
	cmp	x5, x2
	b.ge	L338
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	ldr	x16, [x3, #0]
	cmp	x4, x16
	b.hi	L339
L338:
	orr	x0, xzr, #1
	ldr	x30, [sp, #8]
	add	sp, sp, #16
	.cfi_adjust_cfa_offset	-16
	ret
	.cfi_endproc

	.text
	.align	3
        .global G(blit_dmb_4)
G(blit_dmb_4):
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_adjust_cfa_offset	16
	.cfi_offset 30, -8
	str	x30, [sp, #8]
L440:
        add     x2, x2, x2
        add     x2, x2, #1
	orr	x5, xzr, #1
L439:
	cmp	x5, x2
	b.ge	L438
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	ldr	x16, [x3, #0]
	cmp	x4, x16
	b.hi	L439
L438:
	orr	x0, xzr, #1
	ldr	x30, [sp, #8]
	add	sp, sp, #16
	.cfi_adjust_cfa_offset	-16
	ret
	.cfi_endproc

	.text
	.align	3
        .global G(blit_dmb_5)
G(blit_dmb_5):
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_adjust_cfa_offset	16
	.cfi_offset 30, -8
	str	x30, [sp, #8]
L640:
        add     x2, x2, x2
        add     x2, x2, #1
	orr	x5, xzr, #1
L639:
	cmp	x5, x2
	b.ge	L638
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	add	x7, x1, x5, lsl #2
	add	x8, x0, x5, lsl #2
	ldr	x9, [x8, #-4]
	dmb	ishld
	str	x9, [x7, #-4]
	add	x5, x5, #2
	ldr	x16, [x3, #0]
	cmp	x4, x16
	b.hi	L639
L638:
	orr	x0, xzr, #1
	ldr	x30, [sp, #8]
	add	sp, sp, #16
	.cfi_adjust_cfa_offset	-16
	ret
	.cfi_endproc

