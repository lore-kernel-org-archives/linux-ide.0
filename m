From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/21] ahci: implement SCR_NOTIFICATION r/w
Date: Mon, 16 Jul 2007 14:29:40 +0900
Message-ID: <11845637802579-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:2693 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479AbXGPF3w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1464069wah
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:51 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Make ahci_scr_read/write() handle SCR_NOTIFICATION if the controller
supports it.  Also, print "sntf" in the cap line if supported.

While at it, convert eight space into a tab in ahci_print_info().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   68 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9faf008..417343e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -99,6 +99,7 @@ enum {
 	HOST_CAP_SSC		= (1 << 14), /* Slumber capable */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
 	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
+	HOST_CAP_SNTF		= (1 << 29), /* SNotification register */
 	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
 
@@ -113,11 +114,11 @@ enum {
 	PORT_TFDATA		= 0x20,	/* taskfile data */
 	PORT_SIG		= 0x24,	/* device TF signature */
 	PORT_CMD_ISSUE		= 0x38, /* command issue */
-	PORT_SCR		= 0x28, /* SATA phy register block */
 	PORT_SCR_STAT		= 0x28, /* SATA phy register: SStatus */
 	PORT_SCR_CTL		= 0x2c, /* SATA phy register: SControl */
 	PORT_SCR_ERR		= 0x30, /* SATA phy register: SError */
 	PORT_SCR_ACT		= 0x34, /* SATA phy register: SActive */
+	PORT_SCR_NTF		= 0x3c, /* SATA phy register: SNotification */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
 	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
@@ -631,39 +632,45 @@ static void ahci_restore_initial_config(struct ata_host *host)
 	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
 }
 
-static int ahci_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val)
+static unsigned ahci_scr_offset(struct ata_port *ap, unsigned int sc_reg)
 {
-	unsigned int sc_reg;
-
-	switch (sc_reg_in) {
-	case SCR_STATUS:	sc_reg = 0; break;
-	case SCR_CONTROL:	sc_reg = 1; break;
-	case SCR_ERROR:		sc_reg = 2; break;
-	case SCR_ACTIVE:	sc_reg = 3; break;
-	default:
-		return -EINVAL;
-	}
+	static const int offset[] = {
+		[SCR_STATUS]		= PORT_SCR_STAT,
+		[SCR_CONTROL]		= PORT_SCR_CTL,
+		[SCR_ERROR]		= PORT_SCR_ERR,
+		[SCR_ACTIVE]		= PORT_SCR_ACT,
+		[SCR_NOTIFICATION]	= PORT_SCR_NTF,
+	};
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 
-	*val = readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (sc_reg < ARRAY_SIZE(offset) &&
+	    (sc_reg != SCR_NOTIFICATION || (hpriv->cap & HOST_CAP_SNTF)))
+		return offset[sc_reg];
 	return 0;
 }
 
-
-static int ahci_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
+static int ahci_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
-	unsigned int sc_reg;
-
-	switch (sc_reg_in) {
-	case SCR_STATUS:	sc_reg = 0; break;
-	case SCR_CONTROL:	sc_reg = 1; break;
-	case SCR_ERROR:		sc_reg = 2; break;
-	case SCR_ACTIVE:	sc_reg = 3; break;
-	default:
-		return -EINVAL;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	int offset = ahci_scr_offset(ap, sc_reg);
+
+	if (offset) {
+		*val = readl(port_mmio + offset);
+		return 0;
 	}
+	return -EINVAL;
+}
 
-	writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
-	return 0;
+static int ahci_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	int offset = ahci_scr_offset(ap, sc_reg);
+
+	if (offset) {
+		writel(val, port_mmio + offset);
+		return 0;
+	}
+	return -EINVAL;
 }
 
 static void ahci_start_engine(struct ata_port *ap)
@@ -1768,12 +1775,13 @@ static void ahci_print_info(struct ata_host *host)
 
 	dev_printk(KERN_INFO, &pdev->dev,
 		"flags: "
-	       	"%s%s%s%s%s%s"
-	       	"%s%s%s%s%s%s%s\n"
+		"%s%s%s%s%s%s%s"
+		"%s%s%s%s%s%s%s\n"
 	       	,
 
 		cap & (1 << 31) ? "64bit " : "",
 		cap & (1 << 30) ? "ncq " : "",
+		cap & (1 << 29) ? "sntf " : "",
 		cap & (1 << 28) ? "ilck " : "",
 		cap & (1 << 27) ? "stag " : "",
 		cap & (1 << 26) ? "pm " : "",
@@ -1842,10 +1850,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		void __iomem *port_mmio = ahci_port_base(ap);
 
 		/* standard SATA port setup */
-		if (hpriv->port_map & (1 << i)) {
+		if (hpriv->port_map & (1 << i))
 			ap->ioaddr.cmd_addr = port_mmio;
-			ap->ioaddr.scr_addr = port_mmio + PORT_SCR;
-		}
 
 		/* disabled/not-implemented port */
 		else
-- 
1.5.0.3


