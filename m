From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 07/14] sata_mv Use hqtag instead of ioid
Date: Thu, 24 Jan 2008 16:00:55 -0500
Message-ID: <4798FC87.3080102@rtr.ca>
References: <4798FB68.70400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1910 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756717AbYAXVA4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 16:00:56 -0500
In-Reply-To: <4798FB68.70400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_mv Use hqtag instead of ioid.

Simplify tag handling by using the cid/hqtag field instead of ioid,
as recommended by Marvell.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-24 12:07:16.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 12:35:14.000000000 -0500
@@ -132,15 +132,12 @@
 
 	CRQB_FLAG_READ		= (1 << 0),
 	CRQB_TAG_SHIFT		= 1,
-	CRQB_IOID_SHIFT		= 6,	/* CRQB Gen-II/IIE IO Id shift */
 	CRQB_HOSTQ_SHIFT	= 17,	/* CRQB Gen-II/IIE HostQueTag shift */
 	CRQB_CMD_ADDR_SHIFT	= 8,
 	CRQB_CMD_CS		= (0x2 << 11),
 	CRQB_CMD_LAST		= (1 << 15),
 
 	CRPB_FLAG_STATUS_SHIFT	= 8,
-	CRPB_IOID_SHIFT_6	= 5,	/* CRPB Gen-II IO Id shift */
-	CRPB_IOID_SHIFT_7	= 7,	/* CRPB Gen-IIE IO Id shift */
 
 	EPRD_FLAG_END_OF_TBL	= (1 << 31),
 
@@ -1252,7 +1249,6 @@
 		flags |= CRQB_FLAG_READ;
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
-	flags |= qc->tag << CRQB_IOID_SHIFT;	/* 50xx appears to ignore this*/
 
 	/* get current queue index from software */
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
@@ -1345,8 +1341,7 @@
 
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
-	flags |= qc->tag << CRQB_IOID_SHIFT;	/* "I/O Id" is -really-
-						   what we use as our tag */
+	flags |= qc->tag << CRQB_HOSTQ_SHIFT;
 
 	/* get current queue index from software */
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
@@ -1587,13 +1582,8 @@
 		 * support for queueing.  this works transparently for
 		 * queued and non-queued modes.
 		 */
-		else if (IS_GEN_II(hpriv))
-			tag = (le16_to_cpu(pp->crpb[out_index].id)
-				>> CRPB_IOID_SHIFT_6) & 0x3f;
-
-		else /* IS_GEN_IIE */
-			tag = (le16_to_cpu(pp->crpb[out_index].id)
-				>> CRPB_IOID_SHIFT_7) & 0x3f;
+		else
+			tag = le16_to_cpu(pp->crpb[out_index].id) & 0x1f;
 
 		qc = ata_qc_from_tag(ap, tag);
 
