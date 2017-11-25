From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] pata_pdc2027x: Remove unnecessary error check and coding style error.
Date: Sat, 25 Nov 2017 09:45:40 +0530
Message-ID: <9c2e4c1081be44da4460072ae6129d29c7e6d6bc.1511583254.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37703 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdKYEP4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Nov 2017 23:15:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Here, The function pdc_hardware_init always return zero. So it is not
necessary to check its return value.

Fix these checkpatch.pl error:

ERROR: space prohibited after that '~' (ctx:WxW)
+		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));

ERROR: spaces required around that '?' (ctx:VxW)
+	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;

ERROR: that open brace { should be on the previous line
+	const struct ata_port_info *ppi[] =
+		{ &pdc2027x_port_info[board_idx], NULL };

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/pata_pdc2027x.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index ffd8d33..9a953ef 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -277,7 +277,7 @@ static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long
 			  ATA_ID_PROD_LEN + 1);
 	/* If the master is a maxtor in UDMA6 then the slave should not use UDMA 6 */
 	if (strstr(model_num, "Maxtor") == NULL && pair->dma_mode == XFER_UDMA_6)
-		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
+		mask &= ~(1 << (6 + ATA_SHIFT_UDMA));
 
 	return mask;
 }
@@ -520,7 +520,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
 	u16 pll_ctl;
 	long pll_clock_khz = pll_clock / 1000;
-	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
+	long pout_required = board_idx ? PDC_133_MHZ:PDC_100_MHZ;
 	long ratio = pout_required / pll_clock_khz;
 	int F, R;
 
@@ -707,8 +707,8 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
 	static const unsigned long cmd_offset[] = { 0x17c0, 0x15c0 };
 	static const unsigned long bmdma_offset[] = { 0x1000, 0x1008 };
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	const struct ata_port_info *ppi[] =
-		{ &pdc2027x_port_info[board_idx], NULL };
+	const struct ata_port_info *ppi[] = {
+		&pdc2027x_port_info[board_idx], NULL };
 	struct ata_host *host;
 	void __iomem *mmio_base;
 	int i, rc;
@@ -753,8 +753,7 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
 	//pci_enable_intx(pdev);
 
 	/* initialize adapter */
-	if (pdc_hardware_init(host, board_idx) != 0)
-		return -EIO;
+	pdc_hardware_init(host, board_idx);
 
 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
@@ -778,8 +777,7 @@ static int pdc2027x_reinit_one(struct pci_dev *pdev)
 	else
 		board_idx = PDC_UDMA_133;
 
-	if (pdc_hardware_init(host, board_idx))
-		return -EIO;
+	pdc_hardware_init(host, board_idx);
 
 	ata_host_resume(host);
 	return 0;
-- 
2.7.4

