From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 06/13] sata_mv ncq Use hqtag instead of ioid
Date: Sat, 26 Jan 2008 18:31:48 -0500
Message-ID: <479BC2E4.5040106@rtr.ca>
References: <479BC217.60709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3055 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686AbYAZXbt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 18:31:49 -0500
In-Reply-To: <479BC217.60709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Simplify tag handling by using the cid/hqtag field instead of ioid,
as recommended by Marvell.

Signed-off-by: Mark Lord <mlord@pobox.com> 

--- old/drivers/ata/sata_mv.c	2008-01-26 10:46:58.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-26 10:47:35.000000000 -0500
@@ -1252,7 +1252,6 @@
 		flags |= CRQB_FLAG_READ;
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
-	flags |= qc->tag << CRQB_IOID_SHIFT;	/* 50xx appears to ignore this*/
 
 	/* get current queue index from software */
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
@@ -1345,8 +1344,7 @@
 
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
-	flags |= qc->tag << CRQB_IOID_SHIFT;	/* "I/O Id" is -really-
-						   what we use as our tag */
+	flags |= qc->tag << CRQB_HOSTQ_SHIFT;
 
 	/* get current queue index from software */
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
@@ -1587,13 +1585,8 @@
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
 
