From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] libata: add CFA specific identify data words
Date: Tue, 3 Mar 2009 21:29:29 +0400
Message-ID: <200903032029.29073.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.79.90.228] ([213.79.90.228]:41186 "EHLO
	buildserver.ru.mvista.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753561AbZCCR25 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Mar 2009 12:28:57 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, stf_xl@wp.pl

Declare and use constants for CFA specific identify data words 162 and 163.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the current pata-2.6 series. I'd prefer that Bart merged
it thru his tree as my next patch adding CF mode support to IDE depends on it.

 drivers/ata/libata-core.c |    7 ++++---
 include/linux/ata.h       |    2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-core.c
+++ linux-2.6/drivers/ata/libata-core.c
@@ -1650,8 +1650,8 @@ unsigned long ata_id_xfermask(const u16 
 		/*
 		 *	Process compact flash extended modes
 		 */
-		int pio = id[163] & 0x7;
-		int dma = (id[163] >> 3) & 7;
+		int pio = (id[ATA_ID_CFA_MODES] >> 0) & 0x7;
+		int dma = (id[ATA_ID_CFA_MODES] >> 3) & 0x7;
 
 		if (pio)
 			pio_mask |= (1 << 5);
@@ -2408,7 +2408,8 @@ int ata_dev_configure(struct ata_device 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
 		if (ata_id_is_cfa(id)) {
-			if (id[162] & 1) /* CPRM may make this media unusable */
+			/* CPRM may make this media unusable */
+			if (id[ATA_ID_CFA_KEY_MGMT] & 1)
 				ata_dev_printk(dev, KERN_WARNING,
 					       "supports DRM functions and may "
 					       "not be fully accessable.\n");
Index: linux-2.6/include/linux/ata.h
===================================================================
--- linux-2.6.orig/include/linux/ata.h
+++ linux-2.6/include/linux/ata.h
@@ -89,6 +89,8 @@ enum {
 	ATA_ID_DLF		= 128,
 	ATA_ID_CSFO		= 129,
 	ATA_ID_CFA_POWER	= 160,
+	ATA_ID_CFA_KEY_MGMT	= 162,
+	ATA_ID_CFA_MODES	= 163,
 	ATA_ID_ROT_SPEED	= 217,
 	ATA_ID_PIO4		= (1 << 1),
 

