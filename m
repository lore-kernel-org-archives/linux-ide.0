From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH] pata_scc.c: Workaround
	for errata A308
Date: Tue, 10 Jul 2007 18:29:34 +0900
Message-ID: <200707100929.l6A9TOR8025778@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx9.toshiba.co.jp ([202.33.96.51]:41313 "EHLO
	imx9.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817AbXGJJ71 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 05:59:27 -0400
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5 [202.33.96.24])
	by imx9.toshiba.co.jp  with ESMTP id l6A9xPQ1012736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 18:59:26 +0900 (JST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l6A9TPE1012317
	for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 18:29:25 +0900 (JST)
Received: (from root@localhost)
	by tsb-wall.toshiba.co.jp  id l6A9TPBY018916
	for linux-ide@vger.kernel.org; Tue, 10 Jul 2007 18:29:25 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l6A9TO0F009513
	for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 18:29:25 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

Workaround for errata A308: turn down the UDMA mode and retry
the DMA command when the data lost condition is detected.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -purN -X linux-powerpc-git/Documentation/dontdiff linux-powerpc-git/drivers/ata/pata_scc.c linux-powerpc-git.mod/drivers/ata/pata_scc.c
--- linux-powerpc-git/drivers/ata/pata_scc.c	2007-06-11 12:03:24.000000000 +0900
+++ linux-powerpc-git.mod/drivers/ata/pata_scc.c	2007-07-10 17:13:01.000000000 +0900
@@ -238,6 +238,12 @@ static void scc_set_dmamode (struct ata_
 	else
 		offset = 0;	/* 100MHz */
 
+	/* errata A308 workaround: limit ATAPI UDMA mode to UDMA4 */
+	if (adev->class == ATA_DEV_ATAPI && speed > XFER_UDMA_4) {
+		printk(KERN_INFO "%s: limit ATAPI UDMA to UDMA4\n", DRV_NAME);
+		speed = XFER_UDMA_4;
+	}
+
 	if (speed >= XFER_UDMA_0)
 		idx = speed - XFER_UDMA_0;
 	else
@@ -724,22 +730,36 @@ static void scc_bmdma_stop (struct ata_q
 
 static u8 scc_bmdma_status (struct ata_port *ap)
 {
-	u8 host_stat;
 	void __iomem *mmio = ap->ioaddr.bmdma_addr;
-
-	host_stat = in_be32(mmio + SCC_DMA_STATUS);
-
-	/* Workaround for PTERADD: emulate DMA_INTR when
-	 * - IDE_STATUS[ERR] = 1
-	 * - INT_STATUS[INTRQ] = 1
-	 * - DMA_STATUS[IORACTA] = 1
-	 */
-	if (!(host_stat & ATA_DMA_INTR)) {
-		u32 int_status = in_be32(mmio + SCC_DMA_INTST);
-		if (ata_altstatus(ap) & ATA_ERR &&
-		    int_status & INTSTS_INTRQ &&
-		    host_stat & ATA_DMA_ACTIVE)
-			host_stat |= ATA_DMA_INTR;
+	u8 host_stat = in_be32(mmio + SCC_DMA_STATUS);
+	u32 int_status = in_be32(mmio + SCC_DMA_INTST);
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	static int retry = 0;
+
+	/* return if IOS_SS is cleared */
+	if (!(in_be32(mmio + SCC_DMA_CMD) & ATA_DMA_START))
+		return host_stat;
+
+	/* errata A252,A308 workaround: Step4 */
+	if (ata_altstatus(ap) & ATA_ERR && int_status & INTSTS_INTRQ)
+		return (host_stat | ATA_DMA_INTR);
+
+	/* errata A308 workaround Step5 */
+	if (int_status & INTSTS_IOIRQS) {
+		host_stat |= ATA_DMA_INTR;
+
+		/* We don't check ATAPI DMA because it is limited to UDMA4 */
+		if ((qc->tf.protocol == ATA_PROT_DMA &&
+		     qc->dev->xfer_mode > XFER_UDMA_4)) {
+			if (!(int_status & INTSTS_ACTEINT)) {
+				printk(KERN_WARNING "ata%u: data lost occurred. (ACTEINT==0, retry:%d)\n",
+				       ap->print_id, retry);
+				host_stat |= ATA_DMA_ERR;
+				if (retry++)
+					ap->udma_mask >>= 1;
+			} else
+				retry = 0;
+		}
 	}
 
 	return host_stat;

