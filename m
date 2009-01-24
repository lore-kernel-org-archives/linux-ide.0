From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-generic: use struct ide_port_info
Date: Sat, 24 Jan 2009 15:16:10 +0100
Message-ID: <200901241516.10142.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:62674 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbZAXOVV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 09:21:21 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-generic: use struct ide_port_info

This fixes hwif->channel and drive->dn assignments.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -32,6 +32,10 @@ static int probe_mask;
 module_param(probe_mask, int, 0);
 MODULE_PARM_DESC(probe_mask, "probe mask for legacy ISA IDE ports");
 
+static const struct ide_port_info ide_generic_port_info = {
+	.host_flags		= IDE_HFLAG_NO_DMA,
+};
+
 static ssize_t store_add(struct class *cls, const char *buf, size_t n)
 {
 	unsigned int base, ctl;
@@ -46,7 +50,7 @@ static ssize_t store_add(struct class *c
 	hw.irq = irq;
 	hw.chipset = ide_generic;
 
-	rc = ide_host_add(NULL, hws, NULL);
+	rc = ide_host_add(&ide_generic_port_info, hws, NULL);
 	if (rc)
 		return rc;
 
@@ -184,7 +188,7 @@ static int __init ide_generic_init(void)
 #endif
 			hw.chipset = ide_generic;
 
-			rc = ide_host_add(NULL, hws, NULL);
+			rc = ide_host_add(&ide_generic_port_info, hws, NULL);
 			if (rc) {
 				release_region(io_addr + 0x206, 1);
 				release_region(io_addr, 8);
