From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] ahci: get JMicron JMB360 working
Date: Sun, 29 Jan 2006 00:04:34 -0500
Message-ID: <20060129050434.GA19047@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:9859 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750827AbWA2FEh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jan 2006 00:04:37 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


I'll be sending this upstream sooner rather than later, since part of
this is a needed bugfix.  This is also a minor milestone:  the first
non-Intel AHCI implementation is working with the AHCI driver.  AHCI is
a nice SATA controller interface, and it's good to see other vendors
using it.  VIA is using it as well, and I hope to integrate a patch for
VIA AHCI SATA support soon.

This patch, against latest 2.6.16-rc-git, adds support for JMicron and
fixes some code that should be Intel-only, but was being executed for
all vendors.


diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 19bd346..2fffc7b 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -286,6 +286,8 @@ static const struct pci_device_id ahci_p
 	  board_ahci }, /* ICH8M */
 	{ PCI_VENDOR_ID_INTEL, 0x282a, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH8M */
+	{ 0x197b, 0x2360, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* JMicron JMB360 */
 	{ }	/* terminate list */
 };
 
@@ -802,7 +804,6 @@ static int ahci_host_init(struct ata_pro
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	void __iomem *mmio = probe_ent->mmio_base;
 	u32 tmp, cap_save;
-	u16 tmp16;
 	unsigned int i, j, using_dac;
 	int rc;
 	void __iomem *port_mmio;
@@ -836,9 +837,13 @@ static int ahci_host_init(struct ata_pro
 	writel(0xf, mmio + HOST_PORTS_IMPL);
 	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
 
-	pci_read_config_word(pdev, 0x92, &tmp16);
-	tmp16 |= 0xf;
-	pci_write_config_word(pdev, 0x92, tmp16);
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
+		u16 tmp16;
+
+		pci_read_config_word(pdev, 0x92, &tmp16);
+		tmp16 |= 0xf;
+		pci_write_config_word(pdev, 0x92, tmp16);
+	}
 
 	hpriv->cap = readl(mmio + HOST_CAP);
 	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
@@ -1082,6 +1087,10 @@ static int ahci_init_one (struct pci_dev
 	if (have_msi)
 		hpriv->flags |= AHCI_FLAG_MSI;
 
+	/* JMicron-specific fixup: make sure we're in AHCI mode */
+	if (pdev->vendor == 0x197b)
+		pci_write_config_byte(pdev, 0x41, 0xa1);
+
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
