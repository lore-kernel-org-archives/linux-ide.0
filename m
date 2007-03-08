From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_efar: Switch back to cable methods
Date: Thu, 8 Mar 2007 19:33:29 +0000
Message-ID: <20070308193329.0100f5c9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34193 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932414AbXCHS3R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:29:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_efar.c linux-2.6.21-rc3-mm2/drivers/ata/pata_efar.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_efar.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_efar.c	2007-03-08 17:08:32.000000000 +0000
@@ -22,10 +22,10 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_efar"
-#define DRV_VERSION	"0.4.3"
+#define DRV_VERSION	"0.4.4"
 
 /**
- *	efar_pre_reset	-	check for 40/80 pin
+ *	efar_pre_reset	-	Enable bits
  *	@ap: Port
  *	@deadline: deadline jiffies for the operation
  *
@@ -41,16 +41,8 @@
 	};
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 tmp;
-
 	if (!pci_test_config_bits(pdev, &efar_enable_bits[ap->port_no]))
 		return -ENOENT;
-
-	pci_read_config_byte(pdev, 0x47, &tmp);
-	if (tmp & (2 >> ap->port_no))
-		ap->cbl = ATA_CBL_PATA40;
-	else
-		ap->cbl = ATA_CBL_PATA80;
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -68,6 +60,25 @@
 }
 
 /**
+ *	efar_cable_detect	-	check for 40/80 pin
+ *	@ap: Port
+ *
+ *	Perform cable detection for the EFAR ATA interface. This is
+ *	different to the PIIX arrangement
+ */
+
+static int efar_cable_detect(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 tmp;
+
+	pci_read_config_byte(pdev, 0x47, &tmp);
+	if (tmp & (2 >> ap->port_no))
+		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA80;
+}
+
+/**
  *	efar_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
  *	@adev: um
@@ -257,6 +268,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= efar_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= efar_cable_detect,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
