From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 01/02] sata_mv: tidy up qc->tf usage in qc_prep() functions
Date: Mon, 13 Apr 2009 11:27:18 -0400
Message-ID: <49E359D6.1090309@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:45538 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbZDMP1V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 11:27:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tidy up qc->tf accesses in the mv_qc_prep() functions.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

For upstream-linus, please.
In preparation for the multi_count errata patch which follows.

--- old/drivers/ata/sata_mv.c.upstream	2009-04-13 09:46:51.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-04-13 10:09:54.000000000 -0400
@@ -1898,17 +1898,17 @@
 	struct ata_port *ap = qc->ap;
 	struct mv_port_priv *pp = ap->private_data;
 	__le16 *cw;
-	struct ata_taskfile *tf;
+	struct ata_taskfile *tf = &qc->tf;
 	u16 flags = 0;
 	unsigned in_index;
 
-	if ((qc->tf.protocol != ATA_PROT_DMA) &&
-	    (qc->tf.protocol != ATA_PROT_NCQ))
+	if ((tf->protocol != ATA_PROT_DMA) &&
+	    (tf->protocol != ATA_PROT_NCQ))
 		return;
 
 	/* Fill in command request block
 	 */
-	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
+	if (!(tf->flags & ATA_TFLAG_WRITE))
 		flags |= CRQB_FLAG_READ;
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
@@ -1924,7 +1924,6 @@
 	pp->crqb[in_index].ctrl_flags = cpu_to_le16(flags);
 
 	cw = &pp->crqb[in_index].ata_cmd[0];
-	tf = &qc->tf;
 
 	/* Sadly, the CRQB cannot accomodate all registers--there are
 	 * only 11 bytes...so we must pick and choose required
@@ -1990,16 +1989,16 @@
 	struct ata_port *ap = qc->ap;
 	struct mv_port_priv *pp = ap->private_data;
 	struct mv_crqb_iie *crqb;
-	struct ata_taskfile *tf;
+	struct ata_taskfile *tf = &qc->tf;
 	unsigned in_index;
 	u32 flags = 0;
 
-	if ((qc->tf.protocol != ATA_PROT_DMA) &&
-	    (qc->tf.protocol != ATA_PROT_NCQ))
+	if ((tf->protocol != ATA_PROT_DMA) &&
+	    (tf->protocol != ATA_PROT_NCQ))
 		return;
 
 	/* Fill in Gen IIE command request block */
-	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
+	if (!(tf->flags & ATA_TFLAG_WRITE))
 		flags |= CRQB_FLAG_READ;
 
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
@@ -2015,7 +2014,6 @@
 	crqb->addr_hi = cpu_to_le32((pp->sg_tbl_dma[qc->tag] >> 16) >> 16);
 	crqb->flags = cpu_to_le32(flags);
 
-	tf = &qc->tf;
 	crqb->ata_cmd[0] = cpu_to_le32(
 			(tf->command << 16) |
 			(tf->feature << 24)
