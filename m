From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Switch most of the remaining SFF drivers to
 ata_sff_port_start
Date: Wed, 22 Aug 2007 22:55:41 +0100
Message-ID: <20070822225541.380ce097@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46618 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758596AbXHVVrz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 17:47:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

This avoids allocating DMA buffers if not needed but at the moment is
mostly just a neatness item.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_acpi.c linux-2.6.23rc3-mm1/drivers/ata/pata_acpi.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_acpi.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_acpi.c	2007-08-22 17:40:49.000000000 +0100
@@ -270,7 +270,7 @@
 	acpi->mask[0] = pacpi_discover_modes(ap, &ap->device[0]);
 	acpi->mask[1] = pacpi_discover_modes(ap, &ap->device[1]);
 
-	ret = ata_port_start(ap);
+	ret = ata_sff_port_start(ap);
 	if (ret < 0)
 		return ret;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_ali.c linux-2.6.23rc3-mm1/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_ali.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_ali.c	2007-08-22 17:41:03.000000000 +0100
@@ -320,7 +320,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -359,7 +359,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -396,7 +396,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -432,7 +432,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_amd.c linux-2.6.23rc3-mm1/drivers/ata/pata_amd.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_amd.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_amd.c	2007-08-22 17:41:03.000000000 +0100
@@ -361,7 +361,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations amd66_port_ops = {
@@ -394,7 +394,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations amd100_port_ops = {
@@ -427,7 +427,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations amd133_port_ops = {
@@ -460,7 +460,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations nv100_port_ops = {
@@ -493,7 +493,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations nv133_port_ops = {
@@ -526,7 +526,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_artop.c linux-2.6.23rc3-mm1/drivers/ata/pata_artop.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_artop.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_artop.c	2007-08-22 17:41:03.000000000 +0100
@@ -361,7 +361,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations artop6260_ops = {
@@ -392,7 +392,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_atiixp.c linux-2.6.23rc3-mm1/drivers/ata/pata_atiixp.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_atiixp.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_atiixp.c	2007-08-22 17:41:19.000000000 +0100
@@ -262,7 +262,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_cmd640.c linux-2.6.23rc3-mm1/drivers/ata/pata_cmd640.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_cmd640.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_cmd640.c	2007-08-22 17:41:19.000000000 +0100
@@ -153,7 +153,7 @@
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct cmd640_reg *timing;
 
-	int ret = ata_port_start(ap);
+	int ret = ata_sff_port_start(ap);
 	if (ret < 0)
 		return ret;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_cs5520.c linux-2.6.23rc3-mm1/drivers/ata/pata_cs5520.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_cs5520.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_cs5520.c	2007-08-22 17:41:19.000000000 +0100
@@ -184,7 +184,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_cs5530.c linux-2.6.23rc3-mm1/drivers/ata/pata_cs5530.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_cs5530.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_cs5530.c	2007-08-22 17:41:19.000000000 +0100
@@ -209,7 +209,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct dmi_system_id palmax_dmi_table[] = {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_cs5535.c linux-2.6.23rc3-mm1/drivers/ata/pata_cs5535.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_cs5535.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_cs5535.c	2007-08-22 17:41:40.000000000 +0100
@@ -206,7 +206,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_cypress.c linux-2.6.23rc3-mm1/drivers/ata/pata_cypress.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_cypress.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_cypress.c	2007-08-22 17:41:40.000000000 +0100
@@ -158,7 +158,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int cy82c693_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_efar.c linux-2.6.23rc3-mm1/drivers/ata/pata_efar.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_efar.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_efar.c	2007-08-22 17:41:40.000000000 +0100
@@ -279,7 +279,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_hpt366.c linux-2.6.23rc3-mm1/drivers/ata/pata_hpt366.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_hpt366.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_hpt366.c	2007-08-22 17:41:40.000000000 +0100
@@ -342,7 +342,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_hpt37x.c linux-2.6.23rc3-mm1/drivers/ata/pata_hpt37x.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_hpt37x.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_hpt37x.c	2007-08-22 17:44:12.000000000 +0100
@@ -673,7 +673,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -710,7 +710,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -748,7 +748,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /*
@@ -786,7 +786,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_hpt3x2n.c linux-2.6.23rc3-mm1/drivers/ata/pata_hpt3x2n.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_hpt3x2n.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_hpt3x2n.c	2007-08-22 17:44:23.000000000 +0100
@@ -391,7 +391,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_hpt3x3.c linux-2.6.23rc3-mm1/drivers/ata/pata_hpt3x3.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_hpt3x3.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_hpt3x3.c	2007-08-22 17:44:23.000000000 +0100
@@ -153,7 +153,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_isapnp.c linux-2.6.23rc3-mm1/drivers/ata/pata_isapnp.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_isapnp.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_isapnp.c	2007-08-22 17:44:23.000000000 +0100
@@ -58,7 +58,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_it8213.c linux-2.6.23rc3-mm1/drivers/ata/pata_it8213.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_it8213.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_it8213.c	2007-08-22 17:44:23.000000000 +0100
@@ -289,7 +289,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_it821x.c linux-2.6.23rc3-mm1/drivers/ata/pata_it821x.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_it821x.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_it821x.c	2007-08-22 17:44:23.000000000 +0100
@@ -559,7 +559,7 @@
 	struct it821x_dev *itdev;
 	u8 conf;
 
-	int ret = ata_port_start(ap);
+	int ret = ata_sff_port_start(ap);
 	if (ret < 0)
 		return ret;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_marvell.c linux-2.6.23rc3-mm1/drivers/ata/pata_marvell.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_marvell.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_marvell.c	2007-08-22 17:46:28.000000000 +0100
@@ -139,7 +139,7 @@
 	.irq_on			= ata_irq_on,
 
 	/* Generic PATA PCI ATA helpers */
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_mpiix.c linux-2.6.23rc3-mm1/drivers/ata/pata_mpiix.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_mpiix.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_mpiix.c	2007-08-22 17:46:53.000000000 +0100
@@ -190,7 +190,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_netcell.c linux-2.6.23rc3-mm1/drivers/ata/pata_netcell.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_netcell.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_netcell.c	2007-08-22 17:46:53.000000000 +0100
@@ -68,7 +68,7 @@
 	.irq_on			= ata_irq_on,
 
 	/* Generic PATA PCI ATA helpers */
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_ns87410.c linux-2.6.23rc3-mm1/drivers/ata/pata_ns87410.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_ns87410.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_ns87410.c	2007-08-22 17:46:53.000000000 +0100
@@ -185,7 +185,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int ns87410_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_oldpiix.c linux-2.6.23rc3-mm1/drivers/ata/pata_oldpiix.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_oldpiix.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_oldpiix.c	2007-08-22 17:46:53.000000000 +0100
@@ -266,7 +266,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_opti.c linux-2.6.23rc3-mm1/drivers/ata/pata_opti.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_opti.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_opti.c	2007-08-22 17:46:53.000000000 +0100
@@ -210,7 +210,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int opti_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_optidma.c linux-2.6.23rc3-mm1/drivers/ata/pata_optidma.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_optidma.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_optidma.c	2007-08-22 17:46:53.000000000 +0100
@@ -398,7 +398,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations optiplus_port_ops = {
@@ -432,7 +432,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_pdc2027x.c linux-2.6.23rc3-mm1/drivers/ata/pata_pdc2027x.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_pdc2027x.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_pdc2027x.c	2007-08-22 17:46:53.000000000 +0100
@@ -173,7 +173,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static struct ata_port_operations pdc2027x_pata133_ops = {
@@ -206,7 +206,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static struct ata_port_info pdc2027x_port_info[] = {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_pdc202xx_old.c linux-2.6.23rc3-mm1/drivers/ata/pata_pdc202xx_old.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_pdc202xx_old.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_pdc202xx_old.c	2007-08-22 17:46:53.000000000 +0100
@@ -275,7 +275,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations pdc2026x_port_ops = {
@@ -308,7 +308,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_qdi.c linux-2.6.23rc3-mm1/drivers/ata/pata_qdi.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_qdi.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_qdi.c	2007-08-22 17:46:53.000000000 +0100
@@ -192,7 +192,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations qdi6580_port_ops = {
@@ -218,7 +218,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_radisys.c linux-2.6.23rc3-mm1/drivers/ata/pata_radisys.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_radisys.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_radisys.c	2007-08-22 17:46:53.000000000 +0100
@@ -231,7 +231,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_rz1000.c linux-2.6.23rc3-mm1/drivers/ata/pata_rz1000.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_rz1000.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_rz1000.c	2007-08-22 17:46:53.000000000 +0100
@@ -99,7 +99,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int rz1000_fifo_disable(struct pci_dev *pdev)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sc1200.c linux-2.6.23rc3-mm1/drivers/ata/pata_sc1200.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sc1200.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_sc1200.c	2007-08-22 17:46:53.000000000 +0100
@@ -227,7 +227,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_serverworks.c linux-2.6.23rc3-mm1/drivers/ata/pata_serverworks.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_serverworks.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_serverworks.c	2007-08-22 17:46:53.000000000 +0100
@@ -348,7 +348,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations serverworks_csb_port_ops = {
@@ -382,7 +382,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int serverworks_fixup_osb4(struct pci_dev *pdev)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sil680.c linux-2.6.23rc3-mm1/drivers/ata/pata_sil680.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sil680.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_sil680.c	2007-08-22 17:46:53.000000000 +0100
@@ -267,7 +267,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sis.c linux-2.6.23rc3-mm1/drivers/ata/pata_sis.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sis.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_sis.c	2007-08-22 17:46:53.000000000 +0100
@@ -557,7 +558,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations sis_133_for_sata_ops = {
@@ -589,7 +590,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations sis_133_early_ops = {
@@ -621,7 +622,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations sis_100_ops = {
@@ -653,7 +654,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations sis_66_ops = {
@@ -685,7 +686,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations sis_old_ops = {
@@ -717,7 +718,7 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info sis_info = {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sl82c105.c linux-2.6.23rc3-mm1/drivers/ata/pata_sl82c105.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sl82c105.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_sl82c105.c	2007-08-22 17:46:53.000000000 +0100
@@ -254,7 +254,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_triflex.c linux-2.6.23rc3-mm1/drivers/ata/pata_triflex.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_triflex.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_triflex.c	2007-08-22 17:46:53.000000000 +0100
@@ -227,7 +227,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_via.c linux-2.6.23rc3-mm1/drivers/ata/pata_via.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_via.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_via.c	2007-08-22 17:46:53.000000000 +0100
@@ -367,7 +370,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations via_port_ops_noirq = {
@@ -401,7 +404,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_winbond.c linux-2.6.23rc3-mm1/drivers/ata/pata_winbond.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_winbond.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_winbond.c	2007-08-22 17:46:53.000000000 +0100
@@ -160,7 +160,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/ata_generic.c linux-2.6.23rc3-mm1/drivers/ata/ata_generic.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/ata_generic.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/ata_generic.c	2007-08-22 18:03:03.027739128 +0100
@@ -121,7 +121,7 @@
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int all_generic_ide;		/* Set to claim all devices */
