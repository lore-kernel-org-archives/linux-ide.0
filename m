From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_artop: fix UDMA5 for AEC6280[R] and UDMA6 for AEC6880[R]
Date: Thu, 9 Aug 2007 23:19:34 +0200
Message-ID: <200708092319.34828.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:34923 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbXHIVXD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 17:23:03 -0400
Received: by nf-out-0910.google.com with SMTP id g13so167949nfb
        for <linux-ide@vger.kernel.org>; Thu, 09 Aug 2007 14:23:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Maximum supported UDMA mode for AEC6280[R] is UDMA5 (not UDMA4)
and for AEC6880[R] it is UDMA6 (not UDMA5):

* Fix the problem by adding missing struct ata_port_info to artop_init_one().

* Use the right naming (s/626/628/).

* Bump driver version.

Fixes IDE->libata regression, problem was never present in IDE aec62xx driver.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_artop.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

Index: b/drivers/ata/pata_artop.c
===================================================================
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -2,6 +2,7 @@
  *    pata_artop.c - ARTOP ATA controller driver
  *
  *	(C) 2006 Red Hat <alan@redhat.com>
+ *	(C) 2007 Bartlomiej Zolnierkiewicz
  *
  *    Based in part on drivers/ide/pci/aec62xx.c
  *	Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
@@ -28,7 +29,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_artop"
-#define DRV_VERSION	"0.4.3"
+#define DRV_VERSION	"0.4.4"
 
 /*
  *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
@@ -430,7 +431,7 @@ static int artop_init_one (struct pci_de
 		.udma_mask 	= ATA_UDMA4,
 		.port_ops	= &artop6260_ops,
 	};
-	static const struct ata_port_info info_626x_fast = {
+	static const struct ata_port_info info_628x = {
 		.sht		= &artop_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
@@ -438,6 +439,14 @@ static int artop_init_one (struct pci_de
 		.udma_mask 	= ATA_UDMA5,
 		.port_ops	= &artop6260_ops,
 	};
+	static const struct ata_port_info info_628x_fast = {
+		.sht		= &artop_sht,
+		.flags		= ATA_FLAG_SLAVE_POSS,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask 	= ATA_UDMA6,
+		.port_ops	= &artop6260_ops,
+	};
 	const struct ata_port_info *ppi[] = { NULL, NULL };
 
 	if (!printed_version++)
@@ -455,13 +464,13 @@ static int artop_init_one (struct pci_de
 	}
 	else if (id->driver_data == 1)	/* 6260 */
 		ppi[0] = &info_626x;
-	else if (id->driver_data == 2)	{ /* 6260 or 6260 + fast */
+	else if (id->driver_data == 2)	{ /* 6280 or 6280 + fast */
 		unsigned long io = pci_resource_start(pdev, 4);
 		u8 reg;
 
-		ppi[0] = &info_626x;
+		ppi[0] = &info_628x;
 		if (inb(io) & 0x10)
-			ppi[0] = &info_626x_fast;
+			ppi[0] = &info_628x_fast;
 		/* Mac systems come up with some registers not set as we
 		   will need them */
 
