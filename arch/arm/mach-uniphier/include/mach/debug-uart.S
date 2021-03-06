/*
 * Copyright (C) 2014-2015 Masahiro Yamada <yamada.masahiro@socionext.com>
 *
 * SPDX-License-Identifier:	GPL-2.0+
 */

#include <linux/serial_reg.h>

#if !defined(CONFIG_DEBUG_SEMIHOSTING)
#include CONFIG_DEBUG_LL_INCLUDE
#endif

#define BAUDRATE		115200
#define DIV_ROUND(x, d)		(((x) + ((d) / 2)) / (d))
#define DIVISOR			DIV_ROUND(UART_CLK, 16 * BAUDRATE)

	.macro		init_debug_uart, ra, rb, rc
	addruart	\ra, \rb, \rc
	mov		\rb, #UART_LCR_WLEN8 << 8
	str		\rb, [\ra, #0x10]
	ldr		\rb, =DIVISOR
	str		\rb, [\ra, #0x24]
	.endm
