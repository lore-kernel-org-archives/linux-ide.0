From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] sh: cayman: IDE support fix
Date: Wed, 08 Mar 2017 17:46:43 +0100
Message-ID: <1990884.yFoE6lSB9G@amdc3058>
References: <CGME20170308164645epcas5p12a4884b620557266609e1b941f7ba938@epcas5p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34387 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdCHQ7F (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Mar 2017 11:59:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Remove incorrect CONFIG_IDE ifdef (CONFIG_IDE config option
is for internal drivers/ide/ use) and make IDE hardware
interface always initialized (not only when IDE subsystem
is built-in).

This patch allows Cayman board to work with modular IDE
subsystem support and removes the requirement of having
the whole core IDE subsystem built-in when using libata
PATA support.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Untested.

 arch/sh/boards/mach-cayman/setup.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/arch/sh/boards/mach-cayman/setup.c
===================================================================
--- a/arch/sh/boards/mach-cayman/setup.c	2017-03-08 17:42:01.641323406 +0100
+++ b/arch/sh/boards/mach-cayman/setup.c	2017-03-08 17:42:01.637323406 +0100
@@ -128,7 +128,6 @@ static int __init smsc_superio_setup(voi
 	SMSC_SUPERIO_WRITE_INDEXED(1, SMSC_PRIMARY_INT_INDEX);
 	SMSC_SUPERIO_WRITE_INDEXED(12, SMSC_SECONDARY_INT_INDEX);
 
-#ifdef CONFIG_IDE
 	/*
 	 * Only IDE1 exists on the Cayman
 	 */
@@ -158,7 +157,6 @@ static int __init smsc_superio_setup(voi
 	SMSC_SUPERIO_WRITE_INDEXED(0x01, 0xc5); /* GP45 = IDE1_IRQ */
 	SMSC_SUPERIO_WRITE_INDEXED(0x00, 0xc6); /* GP46 = nIOROP */
 	SMSC_SUPERIO_WRITE_INDEXED(0x00, 0xc7); /* GP47 = nIOWOP */
-#endif
 
 	/* Exit the configuration state */
 	outb(SMSC_EXIT_CONFIG_KEY, SMSC_CONFIG_PORT_ADDR);

