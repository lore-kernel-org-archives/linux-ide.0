From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 08/14] sata_mv Ignore response status LSB on NCQ
Date: Thu, 24 Jan 2008 16:01:23 -0500
Message-ID: <4798FCA3.9050707@rtr.ca>
References: <4798FB68.70400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1917 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755114AbYAXVBY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 16:01:24 -0500
In-Reply-To: <4798FB68.70400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_mv Ignore response status LSB on NCQ.

The lower 8 bits of response status are not valid for NCQ.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-24 12:35:14.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 12:35:43.000000000 -0500
@@ -1587,13 +1587,12 @@
 
 		qc = ata_qc_from_tag(ap, tag);
 
-		/* lower 8 bits of status are EDMA_ERR_IRQ_CAUSE_OFS
-		 * bits (WARNING: might not necessarily be associated
-		 * with this command), which -should- be clear
-		 * if all is well
+		/* For non-NCQ mode, the lower 8 bits of status
+		 * are from EDMA_ERR_IRQ_CAUSE_OFS,
+		 * which should be zero if all went well.
 		 */
 		status = le16_to_cpu(pp->crpb[out_index].flags);
-		if (unlikely(status & 0xff)) {
+		if ((status & 0xff) && !(pp->pp_flags & MV_PP_FLAG_NCQ_EN)) {
 			mv_err_intr(ap, qc);
 			return;
 		}
