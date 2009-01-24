From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide_arm: use struct ide_port_info
Date: Sat, 24 Jan 2009 15:15:22 +0100
Message-ID: <200901241515.22288.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:65257 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbZAXOVW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 09:21:22 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide_arm: use struct ide_port_info

This fixes hwif->channel and drive->dn assignments.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide_arm.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide_arm.c
===================================================================
--- a/drivers/ide/ide_arm.c
+++ b/drivers/ide/ide_arm.c
@@ -18,6 +18,10 @@
 #define IDE_ARM_IO	0x1f0
 #define IDE_ARM_IRQ	IRQ_HARDDISK
 
+static const struct ide_port_info ide_arm_port_info = {
+	.host_flags		= IDE_HFLAG_NO_DMA,
+};
+
 static int __init ide_arm_init(void)
 {
 	unsigned long base = IDE_ARM_IO, ctl = IDE_ARM_IO + 0x206;
@@ -41,7 +45,7 @@ static int __init ide_arm_init(void)
 	hw.irq = IDE_ARM_IRQ;
 	hw.chipset = ide_generic;
 
-	return ide_host_add(NULL, hws, NULL);
+	return ide_host_add(&ide_arm_port_info, hws, NULL);
 }
 
 module_init(ide_arm_init);
