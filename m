From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2 #upstream] ahci: preserve PORTS_IMPL over host resets
Date: Thu, 2 Nov 2006 12:17:23 +0900
Message-ID: <20061102031723.GV13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:47047 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752585AbWKBDRc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 22:17:32 -0500
Received: by ug-out-1314.google.com with SMTP id m3so28821ugc
        for <linux-ide@vger.kernel.org>; Wed, 01 Nov 2006 19:17:31 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, robbat2@gentoo.org
Cc: linux-ide@vger.kernel.org

Instead of writing 0xf blindly, preserve the content of write-once
PORTS_IMPL register over host resets.

This patch is taken from Jeff Garzik's AHCI init update patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Protection against 0 PI is added as suggested in the following
message.

    http://article.gmane.org/gmane.linux.ide/13365

 drivers/ata/ahci.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -389,6 +389,11 @@ static struct pci_driver ahci_pci_driver
 };
 
 
+static inline int ahci_nr_ports(u32 cap)
+{
+	return (cap & 0x1f) + 1;
+}
+
 static inline unsigned long ahci_port_base_ul (unsigned long base, unsigned int port)
 {
 	return base + 0x100 + (port * 0x80);
@@ -598,11 +603,12 @@ static int ahci_deinit_port(void __iomem
 
 static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev)
 {
-	u32 cap_save, tmp;
+	u32 cap_save, impl_save, tmp;
 
 	cap_save = readl(mmio + HOST_CAP);
 	cap_save &= ( (1<<28) | (1<<17) );
 	cap_save |= (1 << 27);
+	impl_save = readl(mmio + HOST_PORTS_IMPL);
 
 	/* global controller reset */
 	tmp = readl(mmio + HOST_CTL);
@@ -623,10 +629,21 @@ static int ahci_reset_controller(void __
 		return -EIO;
 	}
 
+	/* turn on AHCI mode */
 	writel(HOST_AHCI_EN, mmio + HOST_CTL);
 	(void) readl(mmio + HOST_CTL);	/* flush */
+
+	/* These write-once registers are normally cleared on reset.
+	 * Restore BIOS values... which we HOPE were present before
+	 * reset.
+	 */
+	if (!impl_save) {
+		impl_save = (1 << ahci_nr_ports(cap_save)) - 1;
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "PORTS_IMPL is zero, forcing 0x%x\n", impl_save);
+	}
 	writel(cap_save, mmio + HOST_CAP);
-	writel(0xf, mmio + HOST_PORTS_IMPL);
+	writel(impl_save, mmio + HOST_PORTS_IMPL);
 	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
@@ -1431,7 +1448,7 @@ static int ahci_host_init(struct ata_pro
 
 	hpriv->cap = readl(mmio + HOST_CAP);
 	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
-	probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
+	probe_ent->n_ports = ahci_nr_ports(hpriv->cap);
 
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
 		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
