From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v2] pata_pdc2027x: Remove unnecessary error check and coding style error.
Date: Sat, 25 Nov 2017 10:20:29 +0530
Message-ID: <5d7dd8491f0483a93952f26ed557f107c92e006e.1511585163.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33458 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdKYEul (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Nov 2017 23:50:41 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org, joe@perches.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Here, The function pdc_hardware_init always return zero. So it is not
necessary to check its return value. So make the function return void.

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
changes in v2 :
               Make function return type 'void' instead of 'int.
               Add sapce between ':'.

 drivers/ata/pata_pdc2027x.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index ffd8d33..d1e8b63 100644
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
+	long pout_required = board_idx ? PDC_133_MHZ : PDC_100_MHZ;
 	long ratio = pout_required / pll_clock_khz;
 	int F, R;
 
@@ -649,7 +649,7 @@ static long pdc_detect_pll_input_clock(struct ata_host *host)
  * @host: target ATA host
  * @board_idx: board identifier
  */
-static int pdc_hardware_init(struct ata_host *host, unsigned int board_idx)
+static void pdc_hardware_init(struct ata_host *host, unsigned int board_idx)
 {
 	long pll_clock;
 
@@ -665,8 +665,6 @@ static int pdc_hardware_init(struct ata_host *host, unsigned int board_idx)
 
 	/* Adjust PLL control register */
 	pdc_adjust_pll(host, pll_clock, board_idx);
-
-	return 0;
 }
 
 /**
@@ -707,8 +705,8 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
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
@@ -753,8 +751,7 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
 	//pci_enable_intx(pdev);
 
 	/* initialize adapter */
-	if (pdc_hardware_init(host, board_idx) != 0)
-		return -EIO;
+	pdc_hardware_init(host, board_idx);
 
 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
@@ -778,8 +775,7 @@ static int pdc2027x_reinit_one(struct pci_dev *pdev)
 	else
 		board_idx = PDC_UDMA_133;
 
-	if (pdc_hardware_init(host, board_idx))
-		return -EIO;
+	pdc_hardware_init(host, board_idx);
 
 	ata_host_resume(host);
 	return 0;
-- 
2.7.4

