From: Tejun Heo <htejun@gmail.com>
Subject: [RFT PATCH] libata: implement ATA_FLAG_SETXFER_POLLING and use it in pata_via
Date: Thu, 28 Sep 2006 20:11:51 +0900
Message-ID: <20060928111151.GN25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:25517 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751795AbWI1LMB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 07:12:01 -0400
Received: by nf-out-0910.google.com with SMTP id o25so698950nfa
        for <linux-ide@vger.kernel.org>; Thu, 28 Sep 2006 04:12:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: castet.matthieu@free.fr, alan@lxorguk.ukuu.org.uk, jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

This patch implements ATA_FLAG_SETXFER_POLLING and use in pata_via.
If this flag is set, transfer mode setting performed by polling not by
interrupt.  This should help those controllers which raise interrupt
before the command is actually complete on SETXFER.

Rationale for this approach.

* uses existing facility and relatively simple
* no busy sleep in the interrupt handler
* updating drivers is easy

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Matthieu Castet, can you please test this patch?  It's against
libata-dev#upstream, but -mm might work too.  If you want a patch
against -mm, just let me know.

Jeff, Alan, what do you think about this approach?

Thanks.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 753b015..c71d896 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4082,7 +4082,8 @@ int ata_hsm_move(struct ata_port *ap, st
 
 fsm_start:
 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+		ap->id, qc->tf.protocol, ap->hsm_task_state, status,
+		qc->tf.flags & ATA_TFLAG_POLLING);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -4668,6 +4669,14 @@ unsigned int ata_qc_issue_prot(struct at
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
index 1b2ff13..a973718 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -385,7 +385,8 @@ static int via_init_one(struct pci_dev *
 	/* Early VIA without UDMA support */
 	static struct ata_port_info via_mwdma_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops
@@ -393,7 +394,8 @@ static int via_init_one(struct pci_dev *
 	/* Ditto with IRQ masking required */
 	static struct ata_port_info via_mwdma_info_borked = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops_noirq,
@@ -401,7 +403,8 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 33 devices (and borked 66) */
 	static struct ata_port_info via_udma33_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7,
@@ -410,7 +413,8 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 66 devices */
 	static struct ata_port_info via_udma66_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
@@ -419,7 +423,8 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 100 devices */
 	static struct ata_port_info via_udma100_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
@@ -428,7 +433,8 @@ static int via_init_one(struct pci_dev *
 	/* UDMA133 with bad AST (All current 133) */
 	static struct ata_port_info via_udma133_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+			 ATA_FLAG_SETXFER_POLLING,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,	/* FIXME: should check north bridge */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d6a3d4b..9eabc87 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -170,6 +170,7 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
+	ATA_FLAG_SETXFER_POLLING= (1 << 14), /* use polling for SETXFER */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be

