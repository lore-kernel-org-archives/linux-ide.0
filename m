From: Brett Russ <russb@emc.com>
Subject: [PATCH libata-2.6] AHCI: compiler warning fix
Date: Wed, 23 Mar 2005 17:01:40 -0500 (EST)
Message-ID: <20050323220140.1624329937@lns1032.lss.emc.com>
References: <20050311212108.4BB4514FB1@lns1032.lss.emc.com> <4240FB62.7080208@pobox.com>
Received: from mailhub.lss.emc.com ([168.159.2.31]:34517 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261421AbVCWWBv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Mar 2005 17:01:51 -0500
In-Reply-To: <4240FB62.7080208@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff,

This fixes the compile warning below:
drivers/scsi/ahci.c:199: warning: overflow in implicit constant
conversion

This has been sitting in my dir for a while now, sorry for not sending
it sooner.  It turns out that moving the AHCI_DMA_BOUNDARY to the
*bottom* of the current enum also works, since by that point the
compiler can determine that there is no signed data in the enum.
However, I think your suggestion (implemented below) is cleaner
because it doesn't rely on luck to keep the current enum unsigned--it
instead creates a new one intended for unsigned data only.

Signed-off-by: Brett Russ <russb@emc.com>

===== drivers/scsi/ahci.c 1.17 vs edited =====
Index: libata-2.6/drivers/scsi/ahci.c
===================================================================
--- libata-2.6.orig/drivers/scsi/ahci.c	2005-03-11 13:57:22.000000000 -0500
+++ libata-2.6/drivers/scsi/ahci.c	2005-03-12 15:35:58.000000000 -0500
@@ -44,7 +44,6 @@
 enum {
 	AHCI_PCI_BAR		= 5,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
-	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_USE_CLUSTERING	= 0,
 	AHCI_CMD_SLOT_SZ	= 32 * 32,
 	AHCI_RX_FIS_SZ		= 256,
@@ -135,6 +134,12 @@
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 };
 
+/* This enum is intended to be strictly for unsigned data
+ */
+enum {
+	AHCI_DMA_BOUNDARY	= 0xffffffffUL
+};
+
 struct ahci_cmd_hdr {
 	u32			opts;
 	u32			status;
