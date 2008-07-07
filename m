From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/10] ide-generic: minor fix for mips
Date: Mon, 7 Jul 2008 23:53:02 +0200
Message-ID: <200807072353.02859.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:6551 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758229AbYGGWAv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2008 18:00:51 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1051972ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2008 15:00:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

Move ide_probe_legacy() call to ide_generic_init() so it fails
early if necessary and returns the proper error value (nowadays
ide_default_io_base() is used only by ide-generic).

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c           |    4 ++++
 include/asm-mips/mach-generic/ide.h |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -87,6 +87,10 @@ static int __init ide_generic_init(void)
 	unsigned long io_addr;
 	int i, rc;
 
+#ifdef CONFIG_MIPS
+	if (!ide_probe_legacy())
+		return -ENODEV;
+#endif
 	printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" module "
 			 "parameter for probing all legacy ISA IDE ports\n");
 
Index: b/include/asm-mips/mach-generic/ide.h
===================================================================
--- a/include/asm-mips/mach-generic/ide.h
+++ b/include/asm-mips/mach-generic/ide.h
@@ -72,8 +72,6 @@ static __inline__ int ide_default_irq(un
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
-	if (!ide_probe_legacy())
-		return 0;
 	/*
 	 *      If PCI is present then it is not safe to poke around
 	 *      the other legacy IDE ports. Only 0x1f0 and 0x170 are
