From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] sata_mv: fix 50xx irq mask
Date: Sun, 25 Feb 2007 04:23:31 -0500
Message-ID: <20070225092331.GA15203@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:35149 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbXBYJXd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Feb 2007 04:23:33 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>


commit 7aa3ffd983c12d224e33e5d4f89ad083392f9d8d
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sun Feb 25 04:19:45 2007 -0500

    [libata] sata_mv: Fix 50xx irq mask
    
    IRQ mask bits assumed a 60xx or newer generation chip, which is very
    wrong for the 50xx series.  Luckily both generations shared the per-port
    interrupt mask bits, leaving only the "misc chip features" bits to be
    completely mismatched.
    
    Fix 50xx by ensuring we only program bits that exist.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/ata/sata_mv.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

7aa3ffd983c12d224e33e5d4f89ad083392f9d8d
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 30fd84e..208a9d8 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -137,14 +137,19 @@ enum {
 	PCI_ERR			= (1 << 18),
 	TRAN_LO_DONE		= (1 << 19),	/* 6xxx: IRQ coalescing */
 	TRAN_HI_DONE		= (1 << 20),	/* 6xxx: IRQ coalescing */
+	PORTS_0_3_COAL_DONE	= (1 << 8),
+	PORTS_4_7_COAL_DONE	= (1 << 17),
 	PORTS_0_7_COAL_DONE	= (1 << 21),	/* 6xxx: IRQ coalescing */
 	GPIO_INT		= (1 << 22),
 	SELF_INT		= (1 << 23),
 	TWSI_INT		= (1 << 24),
 	HC_MAIN_RSVD		= (0x7f << 25),	/* bits 31-25 */
+	HC_MAIN_RSVD_5		= (0x1fff << 19), /* bits 31-19 */
 	HC_MAIN_MASKED_IRQS	= (TRAN_LO_DONE | TRAN_HI_DONE |
 				   PORTS_0_7_COAL_DONE | GPIO_INT | TWSI_INT |
 				   HC_MAIN_RSVD),
+	HC_MAIN_MASKED_IRQS_5	= (PORTS_0_3_COAL_DONE | PORTS_4_7_COAL_DONE |
+				   HC_MAIN_RSVD_5),
 
 	/* SATAHC registers */
 	HC_CFG_OFS		= 0,
@@ -2239,7 +2244,11 @@ static int mv_init_host(struct pci_dev *pdev, struct ata_probe_ent *probe_ent,
 
 	/* and unmask interrupt generation for host regs */
 	writelfl(PCI_UNMASK_ALL_IRQS, mmio + PCI_IRQ_MASK_OFS);
-	writelfl(~HC_MAIN_MASKED_IRQS, mmio + HC_MAIN_IRQ_MASK_OFS);
+
+	if (IS_50XX(hpriv))
+		writelfl(~HC_MAIN_MASKED_IRQS_5, mmio + HC_MAIN_IRQ_MASK_OFS);
+	else
+		writelfl(~HC_MAIN_MASKED_IRQS, mmio + HC_MAIN_IRQ_MASK_OFS);
 
 	VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x "
 		"PCI int cause/mask=0x%08x/0x%08x\n",
