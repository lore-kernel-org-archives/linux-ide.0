From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] falconide: fix resources reservation
Date: Wed, 20 Feb 2008 01:50:26 +0100
Message-ID: <200802200150.26989.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:33882 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762743AbYBTAgl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 19:36:41 -0500
Received: by mu-out-0910.google.com with SMTP id i10so2608088mue.5
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 16:36:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>

* Tell IDE layer to not manage resources by setting
  hwif->mmio flag and request resources in falconide_init().

* Use request_mem_region() for resources reservation.

* Use driver name for resources reservation.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/falconide.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/legacy/falconide.c
===================================================================
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -22,6 +22,7 @@
 #include <asm/atariints.h>
 #include <asm/atari_stdma.h>
 
+#define DRV_NAME "falconide"
 
     /*
      *  Base of the IDE interface
@@ -74,6 +75,11 @@ static int __init falconide_init(void)
 
 	printk(KERN_INFO "ide: Falcon IDE controller\n");
 
+	if (!request_mem_region(ATA_HD_BASE, 0x40, DRV_NAME)) {
+		printk(KERN_ERR "%s: resources busy\n");
+		return -EBUSY;
+	}
+
 	falconide_setup_ports(&hw);
 
 	hwif = ide_find_port();
@@ -83,6 +89,7 @@ static int __init falconide_init(void)
 
 		ide_init_port_data(hwif, index);
 		ide_init_port_hw(hwif, &hw);
+		hwif->mmio = 1;
 
 		ide_get_lock(NULL, NULL);
 		ide_device_add(idx, NULL);
