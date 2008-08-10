From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove M68K_IDE_SWAPW define from <asm-m68k/ide.h>
Date: Sun, 10 Aug 2008 17:46:12 +0200
Message-ID: <200808101746.12697.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:15451 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754229AbYHJPtv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Aug 2008 11:49:51 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1417867fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 10 Aug 2008 08:49:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>

Since we solved this by overriding default ->{in,out}put_data
methods in {q40,falcon}ide M68K_IDE_SWAP define can go away.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/asm-m68k/ide.h |    9 ---------
 1 file changed, 9 deletions(-)

Index: b/include/asm-m68k/ide.h
===================================================================
--- a/include/asm-m68k/ide.h
+++ b/include/asm-m68k/ide.h
@@ -92,15 +92,6 @@
 #define outsw_swapw(port, addr, n)	raw_outsw_swapw((u16 *)port, addr, n)
 #endif
 
-
-/* Q40 and Atari have byteswapped IDE busses and since many interesting
- * values in the identification string are text, chars and words they
- * happened to be almost correct without swapping.. However *_capacity
- * is needed for drives over 8 GB. RZ */
-#if defined(CONFIG_Q40) || defined(CONFIG_ATARI)
-#define M68K_IDE_SWAPW  (MACH_IS_Q40 || MACH_IS_ATARI)
-#endif
-
 #ifdef CONFIG_BLK_DEV_FALCON_IDE
 #define IDE_ARCH_LOCK
 
