From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v3] pata_pdc2027x: Remove unnecessary error check
Date: Sat, 25 Nov 2017 15:49:49 +0530
Message-ID: <a6bc518e67419242f1409206972590c22f34ba5b.1511604820.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35123 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdKYKUC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 25 Nov 2017 05:20:02 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org, sergei.shtylyov@cogentembedded.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Here, The function pdc_hardware_init always return zero. So it is not
necessary to check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
               Make function return type 'void' instead of 'int.
               Add sapce between ':'.
changes in v3 :
               Fix the checkpatch.pl errors in a sperate patch.

 drivers/ata/pata_pdc2027x.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 82bfd51..6348a83 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
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

