From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH] pata_scc.c: small fixes (Workaround for errata A308)
Date: Tue, 17 Jul 2007 12:10:17 +0900
Message-ID: <200707170309.l6H39tVn005635@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx9.toshiba.co.jp ([202.33.96.51]:42134 "EHLO
	imx9.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbXGQDSB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 23:18:01 -0400
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id l6H3Hxb7014286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 12:18:00 +0900 (JST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l6H39vEP010442
	for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 12:09:57 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l6H39vHT012491
	for linux-ide@vger.kernel.org; Tue, 17 Jul 2007 12:09:57 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l6H39tOv001384
	for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 12:09:56 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: alan@lxorguk.ukuu.org.uk, kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

This patch fixes some issues of the previous patch:
- Use mode_filter() hook to limit ATAPI UDMA mode
- "data loss" warning message
- handling of udma_mask

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-powerpc-git/drivers/ata/pata_scc.c	2007-07-17 10:57:57.000000000 +0900
+++ linux-powerpc-git.mod/drivers/ata/pata_scc.c	2007-07-17 11:02:33.000000000 +0900
@@ -238,12 +238,6 @@ static void scc_set_dmamode (struct ata_
 	else
 		offset = 0;	/* 100MHz */
 
-	/* errata A308 workaround: limit ATAPI UDMA mode to UDMA4 */
-	if (adev->class == ATA_DEV_ATAPI && speed > XFER_UDMA_4) {
-		printk(KERN_INFO "%s: limit ATAPI UDMA to UDMA4\n", DRV_NAME);
-		speed = XFER_UDMA_4;
-	}
-
 	if (speed >= XFER_UDMA_0)
 		idx = speed - XFER_UDMA_0;
 	else
@@ -264,6 +258,17 @@ static void scc_set_dmamode (struct ata_
 		 JCTSStbl[offset][idx] << 16 | JCENVTtbl[offset][idx]);
 }
 
+unsigned long scc_mode_filter(struct ata_device *adev, unsigned long mask)
+{
+	/* errata A308 workaround: limit ATAPI UDMA mode to UDMA4 */
+	if (adev->class == ATA_DEV_ATAPI &&
+	    (mask & (0xE0 << ATA_SHIFT_UDMA))) {
+		printk(KERN_INFO "%s: limit ATAPI UDMA to UDMA4\n", DRV_NAME);
+		mask &= ~(0xE0 << ATA_SHIFT_UDMA);
+	}
+	return ata_pci_default_filter(adev, mask);
+}
+
 /**
  *	scc_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
@@ -741,7 +746,7 @@ static u8 scc_bmdma_status (struct ata_p
 		return host_stat;
 
 	/* errata A252,A308 workaround: Step4 */
-	if (ata_altstatus(ap) & ATA_ERR && int_status & INTSTS_INTRQ)
+	if ((ata_altstatus(ap) & ATA_ERR) && (int_status & INTSTS_INTRQ))
 		return (host_stat | ATA_DMA_INTR);
 
 	/* errata A308 workaround Step5 */
@@ -752,11 +757,11 @@ static u8 scc_bmdma_status (struct ata_p
 		if ((qc->tf.protocol == ATA_PROT_DMA &&
 		     qc->dev->xfer_mode > XFER_UDMA_4)) {
 			if (!(int_status & INTSTS_ACTEINT)) {
-				printk(KERN_WARNING "ata%u: data lost occurred. (ACTEINT==0, retry:%d)\n",
-				       ap->print_id, retry);
+				printk(KERN_WARNING "ata%u: operation failed (transfer data loss)\n",
+				       ap->print_id);
 				host_stat |= ATA_DMA_ERR;
 				if (retry++)
-					ap->udma_mask >>= 1;
+					ap->udma_mask &= ~(1 << qc->dev->xfer_mode);
 			} else
 				retry = 0;
 		}
@@ -1016,7 +1021,7 @@ static const struct ata_port_operations 
 	.port_disable		= ata_port_disable,
 	.set_piomode		= scc_set_piomode,
 	.set_dmamode		= scc_set_dmamode,
-	.mode_filter		= ata_pci_default_filter,
+	.mode_filter		= scc_mode_filter,
 
 	.tf_load		= scc_tf_load,
 	.tf_read		= scc_tf_read,

