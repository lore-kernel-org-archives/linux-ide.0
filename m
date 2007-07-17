From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH] scc_pata.c: Workaround
	for errata A308 (take 2)
Date: Tue, 17 Jul 2007 12:08:02 +0900
Message-ID: <200707170307.l6H37ePZ005944@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx9.toshiba.co.jp ([202.33.96.51]:41891 "EHLO
	imx9.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545AbXGQDPv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 23:15:51 -0400
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id l6H3FiVP014055
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 12:15:45 +0900 (JST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l6H37gRo009433
	for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 12:07:42 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l6H37frH010410
	for linux-ide@vger.kernel.org; Tue, 17 Jul 2007 12:07:41 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l6H37edp029491
	for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 12:07:41 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: sshtylyov@ru.mvista.com, kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

Workaround for errata A308: turn down the UDMA mode and retry
the DMA command when the data lost condition is detected.

take2:
udma_filter() hook is used to limit ATAPI UDMA mode.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-powerpc-git/drivers/ide/pci/scc_pata.c	2007-07-17 11:28:52.000000000 +0900
+++ linux-powerpc-git.mod/drivers/ide/pci/scc_pata.c	2007-07-17 11:21:19.000000000 +0900
@@ -401,6 +401,33 @@ static int scc_ide_dma_end(ide_drive_t *
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long intsts_port = hwif->dma_base + 0x014;
 	u32 reg;
+	int dma_stat, data_loss = 0;
+	static int retry = 0;
+
+	/* errata A308 workaround: Step5 (check data loss) */
+	/* We don't check non ide_disk because it is limited to UDMA4 */
+	if (!(in_be32((void __iomem *)IDE_ALTSTATUS_REG) & ERR_STAT) &&
+	    drive->media == ide_disk && drive->current_speed > XFER_UDMA_4) {
+		reg = in_be32((void __iomem *)intsts_port);
+		if (!(reg & INTSTS_ACTEINT)) {
+			printk(KERN_WARNING "%s: operation failed (transfer data loss)\n",
+			       drive->name);
+			data_loss = 1;
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
@@ -469,27 +496,25 @@ static int scc_ide_dma_end(ide_drive_t *
 		break;
 	}
 
-	return __ide_dma_end(drive);
+	dma_stat = __ide_dma_end(drive);
+	if (data_loss)
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
+	if ((in_be32((void __iomem *)IDE_ALTSTATUS_REG) & ERR_STAT) &&
+	    (int_stat & INTSTS_INTRQ))
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
@@ -498,6 +523,21 @@ static int scc_dma_test_irq(ide_drive_t 
 	return 0;
 }
 
+static u8 scc_udma_filter(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 mask = hwif->ultra_mask;
+
+	/* errata A308 workaround: limit non ide_disk drive to UDMA4 */
+	if ((drive->media != ide_disk) && (mask & 0xE0)) {
+		printk(KERN_INFO "%s: limit %s to UDMA4\n",
+		       SCC_PATA_NAME, drive->name);
+		mask = 0x1F;
+	}
+
+	return mask;
+}
+
 /**
  *	setup_mmio_scc	-	map CTRL/BMID region
  *	@dev: PCI device we are configuring
@@ -702,6 +742,7 @@ static void __devinit init_hwif_scc(ide_
 	hwif->tuneproc = scc_tuneproc;
 	hwif->ide_dma_check = scc_config_drive_for_dma;
 	hwif->ide_dma_test_irq = scc_dma_test_irq;
+	hwif->udma_filter = scc_udma_filter;
 
 	hwif->drives[0].autotune = IDE_TUNE_AUTO;
 	hwif->drives[1].autotune = IDE_TUNE_AUTO;

