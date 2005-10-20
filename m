From: Brett Russ <russb@emc.com>
Subject: [PATCH 2.6.14-rc4] libata: Marvell endian fix
Date: Thu, 20 Oct 2005 08:39:43 -0400 (EDT)
Message-ID: <20051020123943.BF48C2757A@lns1058.lss.emc.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:9673 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S932097AbVJTMjr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Oct 2005 08:39:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff found an endian bug in the Marvell driver (thanks!).  Here's the
fix for it.

Signed-off-by: Brett Russ <russb@emc.com>


Index: linux-2.6.14-rc4/drivers/scsi/sata_mv.c
===================================================================
--- linux-2.6.14-rc4.orig/drivers/scsi/sata_mv.c
+++ linux-2.6.14-rc4/drivers/scsi/sata_mv.c
@@ -35,7 +35,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"0.24"
+#define DRV_VERSION	"0.25"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -799,7 +799,8 @@ static void mv_fill_sg(struct ata_queued
 		pp->sg_tbl[i].flags_size = cpu_to_le32(sg_len);
 	}
 	if (0 < qc->n_elem) {
-		pp->sg_tbl[qc->n_elem - 1].flags_size |= EPRD_FLAG_END_OF_TBL;
+		pp->sg_tbl[qc->n_elem - 1].flags_size |= 
+			cpu_to_le32(EPRD_FLAG_END_OF_TBL);
 	}
 }
 
