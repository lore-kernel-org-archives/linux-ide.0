From: Brett Russ <russb@emc.com>
Subject: [PATCH libata-2.6] AHCI: compiler warning fix
Date: Fri, 11 Mar 2005 16:21:08 -0500 (EST)
Message-ID: <20050311212108.4BB4514FB1@lns1032.lss.emc.com>
Received: from mailhub.lss.emc.com ([168.159.2.31]:36951 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261496AbVCKVXP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Mar 2005 16:23:15 -0500
Received: from lns1032.lss.emc.com (lns1032.lss.emc.com [168.159.31.32])
	by mailhub.lss.emc.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id j2BLNBMd003094
	for <linux-ide@vger.kernel.org>; Fri, 11 Mar 2005 16:23:12 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This fixes the compile warning below, which seems due to the enum
being signed:
drivers/scsi/ahci.c:199: warning: overflow in implicit constant
conversion

Signed-off-by: Brett Russ <russb@emc.com>

===== drivers/scsi/ahci.c 1.17 vs edited =====
--- 1.17/drivers/scsi/ahci.c	Thu Feb 24 14:52:41 2005
+++ edited/drivers/scsi/ahci.c	Wed Mar  9 17:29:36 2005
@@ -44,7 +44,6 @@
 enum {
 	AHCI_PCI_BAR		= 5,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
-	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_USE_CLUSTERING	= 0,
 	AHCI_CMD_SLOT_SZ	= 32 * 32,
 	AHCI_RX_FIS_SZ		= 256,
@@ -135,6 +134,8 @@
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 };
 
+#define AHCI_DMA_BOUNDARY	0xffffffff
+
 struct ahci_cmd_hdr {
 	u32			opts;
 	u32			status;
