From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/6] opti621: disable read prefetch
Date: Wed, 11 Jun 2008 21:57:31 +0200
Message-ID: <200806112157.31569.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:61057 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbYFKU0J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 16:26:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2234746fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 13:26:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Juergen Kosel <juergen.kosel@gmx.de>

This fixes 2.6.25 regression (kernel.org bugzilla bug #10723) caused by:

commit 912fb29a36a7269ac1c4a4df45bc0ac1d2637972
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Fri Oct 19 00:30:11 2007 +0200

    opti621: always tune PIO
...

Based on a bugreport from Juergen Kosel & inspired by pata_opti.c code.

Bisected-by: Juergen Kosel <juergen.kosel@gmx.de>
Tested-by: Juergen Kosel <juergen.kosel@gmx.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
this patch series is against current -git tree

drivers/ide/pci/opti621.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -102,18 +102,6 @@
  *  address: 50 ns, data: 50 ns, recovery: 100 ns.
  */
 
-/* #define READ_PREFETCH 0 */
-/* Uncomment for disable read prefetch.
- * There is some readprefetch capatibility in hdparm,
- * but when I type hdparm -P 1 /dev/hda, I got errors
- * and till reset drive is inaccessible.
- * This (hw) read prefetch is safe on my drive.
- */
-
-#ifndef READ_PREFETCH
-#define READ_PREFETCH 0x40 /* read prefetch is enabled */
-#endif /* else read prefetch is disabled */
-
 #define READ_REG 0	/* index of Read cycle timing register */
 #define WRITE_REG 1	/* index of Write cycle timing register */
 #define CNTRL_REG 3	/* index of Control register */
@@ -264,7 +252,8 @@ static void opti621_set_pio_mode(ide_dri
 
 	cycle1 = ((first.data_time-1)<<4)  | (first.recovery_time-2);
 	cycle2 = ((second.data_time-1)<<4) | (second.recovery_time-2);
-	misc = READ_PREFETCH | ((ax-1)<<4) | ((drdy-2)<<1);
+
+	misc = ((ax - 1) << 4) | ((drdy - 2) << 1);
 
 #ifdef OPTI621_DEBUG
 	printk("%s: master: address: %d, data: %d, "
