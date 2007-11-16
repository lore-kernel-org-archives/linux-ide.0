From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_sil680: kill bogus reset code (take 2)
Date: Fri, 16 Nov 2007 19:50:04 +0300
Message-ID: <200711161950.04670.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:6177 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753356AbXKPQtw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 11:49:52 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Since writing to two reserved bits ain't much of a housekeeping, I think it's
time we get rid of the custom error handler in this driver. ;-)

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Oops, somehow I've managed to send a stale patch, without a version change...
This code has been discussed 4 months ago, and is still in the same state. :-|
The patch is against the Linus' tree...

 drivers/ata/pata_sil680.c |   32 ++------------------------------
 1 files changed, 2 insertions(+), 30 deletions(-)

Index: linux-2.6/drivers/ata/pata_sil680.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_sil680.c
+++ linux-2.6/drivers/ata/pata_sil680.c
@@ -33,7 +33,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_sil680"
-#define DRV_VERSION "0.4.7"
+#define DRV_VERSION "0.4.8"
 
 #define SIL680_MMIO_BAR		5
 
@@ -94,34 +94,6 @@ static int sil680_cable_detect(struct at
 }
 
 /**
- *	sil680_bus_reset	-	reset the SIL680 bus
- *	@link: ATA link to reset
- *	@deadline: deadline jiffies for the operation
- *
- *	Perform the SIL680 housekeeping when doing an ATA bus reset
- */
-
-static int sil680_bus_reset(struct ata_link *link, unsigned int *classes,
-			    unsigned long deadline)
-{
-	struct ata_port *ap = link->ap;
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned long addr = sil680_selreg(ap, 0);
-	u8 reset;
-
-	pci_read_config_byte(pdev, addr, &reset);
-	pci_write_config_byte(pdev, addr, reset | 0x03);
-	udelay(25);
-	pci_write_config_byte(pdev, addr, reset);
-	return ata_std_softreset(link, classes, deadline);
-}
-
-static void sil680_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ata_std_prereset, sil680_bus_reset, NULL, ata_std_postreset);
-}
-
-/**
  *	sil680_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
  *	@adev: ATA device
@@ -249,7 +221,7 @@ static struct ata_port_operations sil680
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= sil680_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= sil680_cable_detect,
 

