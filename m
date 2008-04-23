From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata-eh copy result_tf flags from outgoing tf
Date: Wed, 23 Apr 2008 16:33:45 -0400
Message-ID: <480F9D29.4070603@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2185 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbYDWUdo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 16:33:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Fix mis-reporting of NCQ errors by copying tf->flags to result_tf->flags
in libata-eh.  This allows ata_gen_ata_sense() to report the failed
block number correctly to SCSI after a media error during NCQ.

This patch may also be a candidate for backporting to earlier kernels.
Without this fix, SCSI will fail I/O on the entire request rather
than just the bad sector.  That can be bad for a request that was
merged from many independent read reads from different tasks.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- upstream/drivers/ata/libata-eh.c	2008-04-18 09:31:15.000000000 -0400
+++ linux/drivers/ata/libata-eh.c	2008-04-23 16:25:38.000000000 -0400
@@ -1402,6 +1402,7 @@
 	/* we've got the perpetrator, condemn it */
 	qc = __ata_qc_from_tag(ap, tag);
 	memcpy(&qc->result_tf, &tf, sizeof(tf));
+	qc->result_tf.flags = qc->tf.flags;
 	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
