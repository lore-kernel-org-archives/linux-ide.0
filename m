From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH] scc_pata.c: Workaround
	for errata A308
Date: Tue, 10 Jul 2007 18:29:19 +0900
Message-ID: <200707100929.l6A9T9xp007196@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx9.toshiba.co.jp ([202.33.96.51]:39238 "EHLO
	imx9.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667AbXGJJhU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 05:37:20 -0400
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id l6A9bD6w012135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 18:37:13 +0900 (JST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l6A9TAC5022674
	for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 18:29:10 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l6A9TAxm028524
	for linux-ide@vger.kernel.org; Tue, 10 Jul 2007 18:29:10 +0900 (JST)
Received: from mx11.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l6A9T9p7022991
	for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 18:29:09 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

Workaround for errata A308: turn down the UDMA mode and retry
the DMA command when the data lost condition is detected.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -purN -X linux-powerpc-git/Documentation/dontdiff linux-powerpc-git/drivers/ide/pci/scc_pata.c linux-powerpc-git.mod/drivers/ide/pci/scc_pata.c
--- linux-powerpc-git/drivers/ide/pci/scc_pata.c	2007-05-22 13:08:32.000000000 +0900
+++ linux-powerpc-git.mod/drivers/ide/pci/scc_pata.c	2007-07-10 17:10:10.000000000 +0900
@@ -278,6 +278,13 @@ static int scc_tune_chipset(ide_drive_t 
 		offset = 0; /* 100MHz */
 	}
 
+	/* errata A308 workaround: limit non ide_disk drive to UDMA4 */
+	if (drive->media != ide_disk && speed > XFER_UDMA_4) {
+		printk(KERN_INFO "%s: limit drive(media=%x) to UDMA4\n",
+		       SCC_PATA_NAME, drive->media);
+		speed = XFER_UDMA_4;
+	}
+
 	switch (speed) {
 	case XFER_UDMA_6:
 		idx = 6;
@@ -401,6 +408,33 @@ static int scc_ide_dma_end(ide_drive_t *
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long intsts_port = hwif->dma_base + 0x014;
 	u32 reg;
+	int dma_stat, data_lost = 0;
+	static int retry = 0;
+
+	/* errata A308 workaround: Step5 (check data lost) */
+	/* We don't check non ide_disk because it is limited to UDMA4 */
+	if (!(in_be32((void __iomem *)IDE_ALTSTATUS_REG) & ERR_STAT) &&
+	    drive->media == ide_disk && drive->current_speed > XFER_UDMA_4) {
+		reg = in_be32((void __iomem *)intsts_port);
+		if (!(reg & INTSTS_ACTEINT)) {
+			printk(KERN_WARNING "%s: data lost occurred. (ACTEINT==0, retry:%d)\n",
+			       drive->name, retry);
+			data_lost = 1;
+			if (retry++) {
+				struct request *rq = HWGROUP(drive)->rq;
+				int unit;
+				/* ERROR_RESET and drive->crc_count are needed
+				 * to reduce DMA transfer mode in retry process.
+				 */
+				if (rq)
+					rq->errors |= ERROR_RESET;
+				for (unit = 0; unit < MAX_DRIVES; unit++) {
+					ide_drive_t *drive = &hwif->drives[unit];
+					drive->crc_count++;
+				}
+			}
+		}
+	}
 
 	while (1) {
 		reg = in_be32((void __iomem *)intsts_port);
@@ -469,27 +503,25 @@ static int scc_ide_dma_end(ide_drive_t *
 		break;
 	}
 
-	return __ide_dma_end(drive);
+	dma_stat = __ide_dma_end(drive);
+	if (data_lost)
+		dma_stat |= 2; /* emulate DMA error (to retry command) */
+	return dma_stat;
 }
 
 /* returns 1 if dma irq issued, 0 otherwise */
 static int scc_dma_test_irq(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 dma_stat		= hwif->INB(hwif->dma_status);
+	ide_hwif_t *hwif = HWIF(drive);
+	u32 int_stat = in_be32((void __iomem *)hwif->dma_base + 0x014);
 
-	/* return 1 if INTR asserted */
-	if ((dma_stat & 4) == 4)
+	/* SCC errata A252,A308 workaround: Step4 */
+	if (in_be32((void __iomem *)IDE_ALTSTATUS_REG) & ERR_STAT &&
+	    int_stat & INTSTS_INTRQ)
 		return 1;
 
-	/* Workaround for PTERADD: emulate DMA_INTR when
-	 * - IDE_STATUS[ERR] = 1
-	 * - INT_STATUS[INTRQ] = 1
-	 * - DMA_STATUS[IORACTA] = 1
-	 */
-	if (in_be32((void __iomem *)IDE_ALTSTATUS_REG) & ERR_STAT &&
-	    in_be32((void __iomem *)(hwif->dma_base + 0x014)) & INTSTS_INTRQ &&
-		dma_stat & 1)
+	/* SCC errata A308 workaround: Step5 (polling IOIRQS) */
+	if (int_stat & INTSTS_IOIRQS)
 		return 1;
 
 	if (!drive->waiting_for_dma)

