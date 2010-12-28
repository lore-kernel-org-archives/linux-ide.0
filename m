From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH v3] pata_hpt3x2n: clarify about HPT371N support
Date: Tue, 28 Dec 2010 21:46:40 +0300
Message-ID: <201012282146.40654.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:36376 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752893Ab0L1Sr6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Dec 2010 13:47:58 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Commit 28e21c8c0d44cd63bad4c62f94ef0c5a1cb8402c (pata_hpt3x2n: Add HPT371N
support and other bits) forgot to update the driver's Kconfig entry, heading
comment, and module description (that also wrongly claims support of HPT302)
which may confuse users...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

Changes since previous version:
- removed no longer applying comment...

 drivers/ata/Kconfig        |    4 ++--
 drivers/ata/pata_hpt3x2n.c |    6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/ata/Kconfig
===================================================================
--- linux-2.6.orig/drivers/ata/Kconfig
+++ linux-2.6/drivers/ata/Kconfig
@@ -410,11 +410,11 @@ config PATA_HPT37X
 	  If unsure, say N.
 
 config PATA_HPT3X2N
-	tristate "HPT 372N/302N PATA support"
+	tristate "HPT 371N/372N/302N PATA support"
 	depends on PCI
 	help
 	  This option enables support for the N variant HPT PATA
-	  controllers via the new ATA layer
+	  controllers via the new ATA layer.
 
 	  If unsure, say N.
 
Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -1,5 +1,5 @@
 /*
- * Libata driver for the highpoint 372N and 302N UDMA66 ATA controllers.
+ * Libata driver for the HighPoint 371N, 372N, and 302N UDMA66 ATA controllers.
  *
  * This driver is heavily based upon:
  *
@@ -431,8 +431,6 @@ static int hpt3x2n_pci_clock(struct pci_
  *	HPT372N			9 (HPT372N)	*	UDMA133
  *
  *	(1) UDMA133 support depends on the bus clock
- *
- *	To pin down		HPT371N
  */
 
 static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
@@ -579,7 +577,7 @@ static void __exit hpt3x2n_exit(void)
 }
 
 MODULE_AUTHOR("Alan Cox");
-MODULE_DESCRIPTION("low-level driver for the Highpoint HPT3x2n/30x");
+MODULE_DESCRIPTION("low-level driver for the Highpoint HPT3xxN");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, hpt3x2n);
 MODULE_VERSION(DRV_VERSION);
