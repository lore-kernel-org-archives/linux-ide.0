From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ide: pmac: Remove casting the return value which is a void
 pointer
Date: Mon, 09 Sep 2013 14:41:14 +0900
Message-ID: <005701cead1f$32bf91d0$983eb570$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44015 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab3IIFlQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Sep 2013 01:41:16 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSU00IVHFRXTOO0@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Mon, 09 Sep 2013 14:41:15 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'David Miller' <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ide/pmac.c |   51 +++++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index bf83d7b..3dd1306 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -416,8 +416,7 @@ static int pmac_ide_init_dma(ide_hwif_t *, const struct ide_port_info *);
 static void pmac_ide_apply_timings(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 
 	if (drive->dn & 1)
 		writel(pmif->timings[1], PMAC_IDE_REG(IDE_TIMING_CONFIG));
@@ -434,8 +433,7 @@ static void pmac_ide_apply_timings(ide_drive_t *drive)
 static void pmac_ide_kauai_apply_timings(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 
 	if (drive->dn & 1) {
 		writel(pmif->timings[1], PMAC_IDE_REG(IDE_KAUAI_PIO_CONFIG));
@@ -454,8 +452,7 @@ static void
 pmac_ide_do_update_timings(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 
 	if (pmif->kind == controller_sh_ata6 ||
 	    pmif->kind == controller_un_ata6 ||
@@ -500,8 +497,7 @@ static void pmac_write_devctl(ide_hwif_t *hwif, u8 ctl)
  */
 static void pmac_ide_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 	const u8 pio = drive->pio_mode - XFER_PIO_0;
 	struct ide_timing *tim = ide_timing_find_mode(XFER_PIO_0 + pio);
 	u32 *timings, t;
@@ -781,8 +777,7 @@ set_timings_mdma(ide_drive_t *drive, int intf_type, u32 *timings, u32 *timings2,
 
 static void pmac_ide_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 	int ret = 0;
 	u32 *timings, *timings2, tl[2];
 	u8 unit = drive->dn & 1;
@@ -919,8 +914,7 @@ static int pmac_ide_do_resume(pmac_ide_hwif_t *pmif)
 
 static u8 pmac_ide_cable_detect(ide_hwif_t *hwif)
 {
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 	struct device_node *np = pmif->node;
 	const char *cable = of_get_property(np, "cable-type", NULL);
 	struct device_node *root = of_find_node_by_path("/");
@@ -951,8 +945,7 @@ static u8 pmac_ide_cable_detect(ide_hwif_t *hwif)
 static void pmac_ide_init_dev(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 
 	if (on_media_bay(pmif)) {
 		if (check_media_bay(pmif->mdev->media_bay) == MB_CD) {
@@ -1228,8 +1221,7 @@ out_free_pmif:
 static int
 pmac_ide_macio_suspend(struct macio_dev *mdev, pm_message_t mesg)
 {
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(&mdev->ofdev.dev);
 	int rc = 0;
 
 	if (mesg.event != mdev->ofdev.dev.power.power_state.event
@@ -1245,8 +1237,7 @@ pmac_ide_macio_suspend(struct macio_dev *mdev, pm_message_t mesg)
 static int
 pmac_ide_macio_resume(struct macio_dev *mdev)
 {
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(&mdev->ofdev.dev);
 	int rc = 0;
 
 	if (mdev->ofdev.dev.power.power_state.event != PM_EVENT_ON) {
@@ -1365,8 +1356,7 @@ pmac_ide_pci_resume(struct pci_dev *pdev)
 #ifdef CONFIG_PMAC_MEDIABAY
 static void pmac_ide_macio_mb_event(struct macio_dev* mdev, int mb_state)
 {
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(&mdev->ofdev.dev);
 
 	switch(mb_state) {
 	case MB_CD:
@@ -1468,8 +1458,7 @@ out:
 static int pmac_ide_build_dmatable(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 	struct dbdma_cmd *table;
 	volatile struct dbdma_regs __iomem *dma = pmif->dma_regs;
 	struct scatterlist *sg;
@@ -1546,8 +1535,7 @@ static int pmac_ide_build_dmatable(ide_drive_t *drive, struct ide_cmd *cmd)
 static int pmac_ide_dma_setup(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 	u8 unit = drive->dn & 1, ata4 = (pmif->kind == controller_kl_ata4);
 	u8 write = !!(cmd->tf_flags & IDE_TFLAG_WRITE);
 
@@ -1572,8 +1560,7 @@ static void
 pmac_ide_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 	volatile struct dbdma_regs __iomem *dma;
 
 	dma = pmif->dma_regs;
@@ -1590,8 +1577,7 @@ static int
 pmac_ide_dma_end (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 	volatile struct dbdma_regs __iomem *dma = pmif->dma_regs;
 	u32 dstat;
 
@@ -1615,8 +1601,7 @@ static int
 pmac_ide_dma_test_irq (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 	volatile struct dbdma_regs __iomem *dma = pmif->dma_regs;
 	unsigned long status, timeout;
 
@@ -1670,8 +1655,7 @@ static void
 pmac_ide_dma_lost_irq (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 	volatile struct dbdma_regs __iomem *dma = pmif->dma_regs;
 	unsigned long status = readl(&dma->status);
 
@@ -1693,8 +1677,7 @@ static const struct ide_dma_ops pmac_dma_ops = {
  */
 static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
 {
-	pmac_ide_hwif_t *pmif =
-		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+	pmac_ide_hwif_t *pmif = dev_get_drvdata(hwif->gendev.parent);
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 
 	/* We won't need pci_dev if we switch to generic consistent
-- 
1.7.10.4


