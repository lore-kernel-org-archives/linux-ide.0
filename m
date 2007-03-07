From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ata_piix: Remove ugly layering violation
Date: Wed, 7 Mar 2007 16:13:07 +0000
Message-ID: <20070307161307.37b1e36f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46494 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751495AbXCGPKK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:10:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

A while ago I modified the libata code so that drivers can return -ENOENT
for unknown ports not fiddle with the EH flags and print stuff directly.
Somewhere along the line ata_piix didn't get fully converted.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/ata_piix.c linux-2.6.21-rc2-mm2/drivers/ata/ata_piix.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/ata_piix.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/ata_piix.c	2007-03-06 23:33:53.000000000 +0000
@@ -93,7 +93,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"2.10"
+#define DRV_VERSION	"2.10ac1"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
@@ -667,14 +667,9 @@
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
-	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no])) {
-		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
-		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
-		return 0;
-	}
-
+	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
+		return -ENOENT;
 	ich_pata_cbl_detect(ap);
-
 	return ata_std_prereset(ap);
 }
 

 
