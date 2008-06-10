From: Shane Huang <shane.huang@amd.com>
Subject: RE: [PATCH] SB600 SATA controller PMP support
Date: Tue, 10 Jun 2008 15:52:04 +0800
Message-ID: <1213084324.5808.6.camel@zm-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-sin.bigfish.com ([207.46.51.74]:33592 "EHLO
	mail167-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbYFJIV5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 04:21:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, shane.huang@amd.com

Hi Tejun and Jeff,

Tejun wrote:
> I think it's in the right direction.  Just a few nits...

I modified the SATA PMP patch with your nice suggestions,
please check the updated one below.

Thanks
Shane

====== CUT HERE =====
There is one bug in ATI SATA PMP of SB600 and SB700 old revision, which leads
to soft reset failure. This patch can fix the bug.

Signed-off-by: Shane Huang <shane.huang@amd.com>
Acked-by: Tejun Heo <htejun@gmail.com>

diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c	2008-06-10 03:27:08.000000000 +0800
+++ b/drivers/ata/ahci.c	2008-06-10 06:15:48.000000000 +0800
@@ -253,6 +253,8 @@
 static void ahci_pmp_detach(struct ata_port *ap);
 static int ahci_softreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline);
+static int ahci_sb600_softreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline);
 static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline);
 static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
@@ -329,6 +331,12 @@
 	.hardreset		= ahci_p5wdh_hardreset,
 };
 
+static struct ata_port_operations ahci_sb600_ops = {
+	.inherits		= &ahci_ops,
+	.softreset		= ahci_sb600_softreset,
+	.pmp_softreset		= ahci_sb600_softreset,
+};
+
 #define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
 
 static const struct ata_port_info ahci_port_info[] = {
@@ -359,11 +367,11 @@
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
 				 AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
-				 AHCI_HFLAG_SECT255 | AHCI_HFLAG_NO_PMP),
+				 AHCI_HFLAG_SECT255),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
+		.port_ops	= &ahci_sb600_ops,
 	},
 	/* board_ahci_mv */
 	{
@@ -377,12 +385,11 @@
 	},
 	/* board_ahci_sb700 */
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
-				 AHCI_HFLAG_NO_PMP),
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
+		.port_ops	= &ahci_sb600_ops,
 	},
 };
 
@@ -1262,19 +1269,11 @@
 	return 0;
 }
 
-static int ahci_check_ready(struct ata_link *link)
-{
-	void __iomem *port_mmio = ahci_port_base(link->ap);
-	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
-
-	return ata_check_ready(status);
-}
-
-static int ahci_softreset(struct ata_link *link, unsigned int *class,
-			  unsigned long deadline)
+static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
+			     int pmp, unsigned long deadline,
+			     int (*check_ready)(struct ata_link *link))
 {
 	struct ata_port *ap = link->ap;
-	int pmp = sata_srst_pmp(link);
 	const char *reason = NULL;
 	unsigned long now, msecs;
 	struct ata_taskfile tf;
@@ -1312,7 +1311,7 @@
 	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);
 
 	/* wait for link to become ready */
-	rc = ata_wait_after_reset(link, deadline, ahci_check_ready);
+	rc = ata_wait_after_reset(link, deadline, check_ready);
 	/* link occupied, -ENODEV too is an error */
 	if (rc) {
 		reason = "device not ready";
@@ -1328,6 +1327,72 @@
 	return rc;
 }
 
+static int ahci_check_ready(struct ata_link *link)
+{
+	void __iomem *port_mmio = ahci_port_base(link->ap);
+	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+
+	return ata_check_ready(status);
+}
+
+static int ahci_softreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline)
+{
+	int pmp = sata_srst_pmp(link);
+
+	DPRINTK("ENTER\n");
+
+	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
+}
+
+static int ahci_sb600_check_ready(struct ata_link *link)
+{
+	void __iomem *port_mmio = ahci_port_base(link->ap);
+	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+	u32 irq_status = readl(port_mmio + PORT_IRQ_STAT);
+
+	/*
+	 * There is no need to check TFDATA if BAD PMP is found due to HW bug,
+	 * which can save timeout delay.
+	 */
+	if (irq_status & PORT_IRQ_BAD_PMP)
+		return -EIO;
+
+	return ata_check_ready(status);
+}
+
+static int ahci_sb600_softreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	int pmp = sata_srst_pmp(link);
+	int rc;
+	u32 irq_sts;
+
+	DPRINTK("ENTER\n");
+
+	rc = ahci_do_softreset(link, class, pmp, deadline,
+			       ahci_sb600_check_ready);
+
+	/*
+	 * Soft reset fails on some ATI chips with IPMS set when PMP
+	 * is enabled but SATA HDD/ODD is connected to SATA port,
+	 * do soft reset again to port 0.
+	 */
+	if (rc == -EIO) {
+		irq_sts = readl(port_mmio + PORT_IRQ_STAT);
+		if (irq_sts & PORT_IRQ_BAD_PMP) {
+			ata_link_printk(link, KERN_WARNING,
+					"failed due to HW bug, retry pmp=0\n");
+			rc = ahci_do_softreset(link, class, 0, deadline,
+					       ahci_check_ready);
+		}
+	}
+
+	return rc;
+}
+
 static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {


