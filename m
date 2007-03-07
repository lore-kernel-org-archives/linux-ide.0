From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_it8213: Cable detect
Date: Wed, 7 Mar 2007 16:46:20 +0000
Message-ID: <20070307164620.09e97228@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58326 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751983AbXCGPmE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:42:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Another not-quite PIIX, another cable type conversion

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_it8213.c linux-2.6.21-rc2-mm2/drivers/ata/pata_it8213.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_it8213.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_it8213.c	2007-03-06 23:35:15.000000000 +0000
@@ -25,8 +25,8 @@
  *	it8213_pre_reset	-	check for 40/80 pin
  *	@ap: Port
  *
- *	Perform cable detection for the 8213 ATA interface. This is
- *	different to the PIIX arrangement
+ *	Filter out ports by the enable bits before doing the normal reset
+ *	and probe.
  */
 
 static int it8213_pre_reset(struct ata_port *ap)
@@ -34,23 +34,14 @@
 	static const struct pci_bits it8213_enable_bits[] = {
 		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
 	};
-
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 tmp;
-
 	if (!pci_test_config_bits(pdev, &it8213_enable_bits[ap->port_no]))
 		return -ENOENT;
-
-	pci_read_config_byte(pdev, 0x42, &tmp);
-	if (tmp & 2)	/* The initial docs are incorrect */
-		ap->cbl = ATA_CBL_PATA40;
-	else
-		ap->cbl = ATA_CBL_PATA80;
 	return ata_std_prereset(ap);
 }
 
 /**
- *	it8213_probe_reset - Probe specified port on PATA host controller
+ *	it8213_error_handler - Probe specified port on PATA host controller
  *	@ap: Port to probe
  *
  *	LOCKING:
@@ -63,9 +54,27 @@
 }
 
 /**
+ *	it8213_cable_detect	-	check for 40/80 pin
+ *	@ap: Port
+ *
+ *	Perform cable detection for the 8213 ATA interface. This is
+ *	different to the PIIX arrangement
+ */
+
+static int it8213_cable_detect(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 tmp;
+	pci_read_config_byte(pdev, 0x42, &tmp);
+	if (tmp & 2)	/* The initial docs are incorrect */
+		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA80;
+}
+
+/**
  *	it8213_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
- *	@adev: um
+ *	@adev: Device whose timings we are configuring
  *
  *	Set PIO mode for device, in host controller PCI config space.
  *
@@ -268,6 +277,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= it8213_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= it8213_cable_detect,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
