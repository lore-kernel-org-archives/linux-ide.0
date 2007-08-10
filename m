From: akpm@linux-foundation.org
Subject: [patch 08/25] ALPM: store interrupt value
Date: Fri, 10 Aug 2007 13:59:38 -0700
Message-ID: <200708102059.l7AKxc08008590@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49006 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937238AbXHJVAr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:00:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, kristen.c.accardi@intel.com, alan@lxorguk.ukuu.org.uk, htejun@gmail.com

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Use a stored value for which interrupts to enable.  Changing this allows us to
selectively turn off certain interrupts later and have them stay off.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/ahci.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

diff -puN drivers/ata/ahci.c~alpm-store-interrupt-value drivers/ata/ahci.c
--- a/drivers/ata/ahci.c~alpm-store-interrupt-value
+++ a/drivers/ata/ahci.c
@@ -175,6 +175,7 @@ enum {
 	AHCI_FLAG_32BIT_ONLY		= (1 << 28), /* force 32bit */
 	AHCI_FLAG_MV_PATA		= (1 << 29), /* PATA port */
 	AHCI_FLAG_NO_MSI		= (1 << 30), /* no PCI MSI */
+	AHCI_FLAG_NO_HOTPLUG		= (1 << 31), /* ignore PxSERR.DIAG.N */
 
 	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 					  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
@@ -215,6 +216,7 @@ struct ahci_port_priv {
 	unsigned int		ncq_saw_d2h:1;
 	unsigned int		ncq_saw_dmas:1;
 	unsigned int		ncq_saw_sdb:1;
+	u32 			intr_mask;	/* interrupts to enable */
 };
 
 static int ahci_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
@@ -1511,6 +1513,7 @@ static void ahci_thaw(struct ata_port *a
 	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
+	struct ahci_port_priv *pp = ap->private_data;
 
 	/* clear IRQ */
 	tmp = readl(port_mmio + PORT_IRQ_STAT);
@@ -1518,7 +1521,7 @@ static void ahci_thaw(struct ata_port *a
 	writel(1 << ap->port_no, mmio + HOST_IRQ_STAT);
 
 	/* turn IRQ back on */
-	writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
+	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
 static void ahci_error_handler(struct ata_port *ap)
@@ -1672,6 +1675,12 @@ static int ahci_port_start(struct ata_po
 	pp->cmd_tbl = mem;
 	pp->cmd_tbl_dma = mem_dma;
 
+	/*
+ 	 * Save off initial list of interrupts to be enabled.
+ 	 * This could be changed later
+ 	 */
+	pp->intr_mask = DEF_PORT_IRQ;
+
 	ap->private_data = pp;
 
 	/* engage engines, captain */
_
