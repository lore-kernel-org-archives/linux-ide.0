From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: implement ATA_FLAG_SETXFER_POLLING and use it in pata_via, take #2
Date: Thu, 16 Nov 2006 10:50:50 +0900
Message-ID: <20061116015050.GB2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:63863 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030579AbWKPBu7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 20:50:59 -0500
Received: by ug-out-1314.google.com with SMTP id m3so327244ugc
        for <linux-ide@vger.kernel.org>; Wed, 15 Nov 2006 17:50:57 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, castet.matthieu@free.fr

This patch implements ATA_FLAG_SETXFER_POLLING and use in pata_via.
If this flag is set, transfer mode setting performed by polling not by
interrupt.  This should help those controllers which raise interrupt
before the command is actually complete on SETXFER.

Rationale for this approach.

* uses existing facility and relatively simple
* no busy sleep in the interrupt handler
* updating drivers is easy

While at it, kill now unused flag ATA_FLAG_SRST in pata_via.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Jeff, this patch is against
  upstream (cfd15b0011498986ef14b6c53f5eaba89d2171f3)
  + detect-polling patchset

detect-polling patchset didn't appear in #upstream yet.  kernel.org
mirroring problem?

Matthieu Castet confirmed that this patch works for him the day before
yesterday.

Changes from the last post are...

* updated to the current devel head
* dropped broken DPRINTK change
* killed ATA_FLAG_SRST in pata_via

Thanks.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4616bb3..54063ab 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4770,6 +4770,14 @@ unsigned int ata_qc_issue_prot(struct at
 		}
 	}
 
+	/* Some controllers show flaky interrupt behavior after
+	 * setting xfer mode.  Use polling instead.
+	 */
+	if (unlikely(qc->tf.command == ATA_CMD_SET_FEATURES &&
+		     qc->tf.feature == SETFEATURES_XFER) &&
+	    (ap->flags & ATA_FLAG_SETXFER_POLLING))
+		qc->tf.flags |= ATA_TFLAG_POLLING;
+
 	/* select the device */
 	ata_dev_select(ap, qc->dev->devno, 1, 0);
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 1e7be9e..46ee454 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -382,7 +382,7 @@ static int via_init_one(struct pci_dev *
 	/* Early VIA without UDMA support */
 	static struct ata_port_info via_mwdma_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops
@@ -390,7 +390,7 @@ static int via_init_one(struct pci_dev *
 	/* Ditto with IRQ masking required */
 	static struct ata_port_info via_mwdma_info_borked = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops_noirq,
@@ -398,7 +398,7 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 33 devices (and borked 66) */
 	static struct ata_port_info via_udma33_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7,
@@ -407,7 +407,7 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 66 devices */
 	static struct ata_port_info via_udma66_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
@@ -416,7 +416,7 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 100 devices */
 	static struct ata_port_info via_udma100_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
@@ -425,7 +425,7 @@ static int via_init_one(struct pci_dev *
 	/* UDMA133 with bad AST (All current 133) */
 	static struct ata_port_info via_udma133_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,	/* FIXME: should check north bridge */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4236efc..e83a33b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -177,6 +177,7 @@ enum {
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_DETECT_POLLING	= (1 << 14), /* detect device presence by
 					      * polling IDENTIFY */
+	ATA_FLAG_SETXFER_POLLING= (1 << 15), /* use polling for SETXFER */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
