From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] libata: use ATA_ID_CFA_*
Date: Mon, 13 Apr 2009 20:50:00 +0400
Message-ID: <200904132050.00352.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:22466 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751731AbZDMQtN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 12:49:13 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Use ATA_ID_CFA_* constants for CFA specific identify data words 162 and 163.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Resending now (when it's too late already :-)...
This patch is against the recent Linus' tree.

 drivers/ata/libata-core.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-core.c
+++ linux-2.6/drivers/ata/libata-core.c
@@ -1653,8 +1653,8 @@ unsigned long ata_id_xfermask(const u16 
 		/*
 		 *	Process compact flash extended modes
 		 */
-		int pio = id[163] & 0x7;
-		int dma = (id[163] >> 3) & 7;
+		int pio = (id[ATA_ID_CFA_MODES] >> 0) & 0x7;
+		int dma = (id[ATA_ID_CFA_MODES] >> 3) & 0x7;
 
 		if (pio)
 			pio_mask |= (1 << 5);
@@ -2412,7 +2412,8 @@ int ata_dev_configure(struct ata_device 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
 		if (ata_id_is_cfa(id)) {
-			if (id[162] & 1) /* CPRM may make this media unusable */
+			/* CPRM may make this media unusable */
+			if (id[ATA_ID_CFA_KEY_MGMT] & 1)
 				ata_dev_printk(dev, KERN_WARNING,
 					       "supports DRM functions and may "
 					       "not be fully accessable.\n");

