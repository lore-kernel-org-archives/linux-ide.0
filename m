From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_hpt37x: fix HPT370 DMA timeouts
Date: Tue, 14 Apr 2009 18:39:14 +0400
Message-ID: <200904141839.14755.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:49470 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750746AbZDNOi3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 10:38:29 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk

The libata driver has copied the code from the IDE driver which caused a post
2.4.18 regression on many HPT370[A] chips -- DMA stopped to work completely,
only causing timeouts.  Now remove hpt370_bmdma_start() for good...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree. It's intended to go into all
stable kernels starting with 2.6.19, when the PATA drivers were first merged.

See http://marc.info/?l=linux-ide&m=123912061904872 for the IDE driver patch.

 drivers/ata/pata_hpt37x.c |   22 ++--------------------
 1 files changed, 2 insertions(+), 20 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -8,7 +8,7 @@
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
- * Portions Copyright (C) 2005-2007	MontaVista Software, Inc.
+ * Portions Copyright (C) 2005-2009	MontaVista Software, Inc.
  *
  * TODO
  *	Look into engine reset on timeout errors. Should not be	required.
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.11"
+#define DRV_VERSION	"0.6.12"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -445,23 +445,6 @@ static void hpt370_set_dmamode(struct at
 }
 
 /**
- *	hpt370_bmdma_start		-	DMA engine begin
- *	@qc: ATA command
- *
- *	The 370 and 370A want us to reset the DMA engine each time we
- *	use it. The 372 and later are fine.
- */
-
-static void hpt370_bmdma_start(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
-	udelay(10);
-	ata_bmdma_start(qc);
-}
-
-/**
  *	hpt370_bmdma_end		-	DMA engine stop
  *	@qc: ATA command
  *
@@ -598,7 +581,6 @@ static struct scsi_host_template hpt37x_
 static struct ata_port_operations hpt370_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 
-	.bmdma_start 	= hpt370_bmdma_start,
 	.bmdma_stop	= hpt370_bmdma_stop,
 
 	.mode_filter	= hpt370_filter,

