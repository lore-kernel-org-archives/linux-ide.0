From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] SB600 SATA controller PMP support
Date: Wed, 4 Jun 2008 10:51:28 +0800
Message-ID: <1212547888.5722.5.camel@chunhao-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:57146 "EHLO
	WA4EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbYFDCwX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2008 22:52:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

There is one bug in SB600 SATA PMP which leads to softreset failure,
this patch can fix the bug.

Signed-off-by: Shane Huang <shane.huang@amd.com>

diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c	2008-06-03 15:23:59.000000000 +0800
+++ b/drivers/ata/ahci.c	2008-06-03 15:20:44.000000000 +0800
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
@@ -1270,11 +1278,24 @@
 	return ata_check_ready(status);
 }
 
-static int ahci_softreset(struct ata_link *link, unsigned int *class,
-			  unsigned long deadline)
+static int ahci_sb600_check_ready(struct ata_link *link)
+{
+	void __iomem *port_mmio = ahci_port_base(link->ap);
+
+	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+	u32 irq_status = readl(port_mmio + PORT_IRQ_STAT);
+
+	if (irq_status & PORT_IRQ_BAD_PMP)
+		return -EIO;
+
+	return ata_check_ready(status);
+}
+
+static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
+			     int pmp, unsigned long deadline,
+			     int (*check_ready)(struct ata_link *link))
 {
 	struct ata_port *ap = link->ap;
-	int pmp = sata_srst_pmp(link);
 	const char *reason = NULL;
 	unsigned long now, msecs;
 	struct ata_taskfile tf;
@@ -1312,15 +1333,12 @@
 	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);
 
 	/* wait for link to become ready */
-	rc = ata_wait_after_reset(link, deadline, ahci_check_ready);
+	rc = ata_wait_after_reset(link, deadline, check_ready);
 	/* link occupied, -ENODEV too is an error */
 	if (rc) {
 		reason = "device not ready";
 		goto fail;
 	}
-	*class = ahci_dev_classify(ap);
-
-	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
  fail:
@@ -1328,6 +1346,57 @@
 	return rc;
 }
 
+static int ahci_softreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	int pmp = sata_srst_pmp(link);
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	rc = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
+	if (!rc) {
+		*class = ahci_dev_classify(ap);
+		DPRINTK("EXIT, class=%u\n", *class);
+	}
+	return rc;
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
+				ahci_sb600_check_ready);
+
+	/* Soft reset fails on some ATI chips with IPMS set when PMP
+	   is enabled but SATA HDD/ODD is connected to SATA port,
+	   do soft reset again to port 0. */
+	if (rc == -EIO) {
+		irq_sts = readl(port_mmio + PORT_IRQ_STAT);
+		if (irq_sts & PORT_IRQ_BAD_PMP) {
+			ata_link_printk(link, KERN_WARNING,
+					"softreset failed, try again\n");
+			rc = ahci_do_softreset(link, class, 0, deadline,
+						ahci_check_ready);
+		}
+	}
+
+	if (!rc) {
+		*class = ahci_dev_classify(ap);
+		DPRINTK("EXIT, class=%u\n", *class);
+	}
+	return rc;
+}
+
 static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {


