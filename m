From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata-eh set tf flags in NCQ EH result_tf
Date: Wed, 23 Apr 2008 22:36:25 -0400
Message-ID: <480FF229.2060808@rtr.ca>
References: <480F9D29.4070603@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1869 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbYDXCg0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 22:36:26 -0400
In-Reply-To: <480F9D29.4070603@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Fix mis-reporting of NCQ errors by ensuring that result_tf->flags
is properly initialized in libata-eh.  This allows ata_gen_ata_sense()
to report the failed block number correctly to SCSI after a media error
during NCQ.

This patch may also be a candidate for backporting to earlier kernels.
Without this fix, SCSI will fail I/O on the entire request rather
than just the bad sector.  That can be bad for a request that was
merged from many independent read reads from different tasks.

Signed-off-by: Mark Lord <mlord@pobox.com> 
---

This is an alternative version of the original patch
which safely copied the outgoing tf.flags to result_tf.flags.
Both work.  Pick one.

--- upstream/drivers/ata/libata-eh.c	2008-04-18 09:31:15.000000000 -0400
+++ linux/drivers/ata/libata-eh.c	2008-04-23 16:25:38.000000000 -0400
@@ -1402,6 +1402,7 @@
 	/* we've got the perpetrator, condemn it */
 	qc = __ata_qc_from_tag(ap, tag);
 	memcpy(&qc->result_tf, &tf, sizeof(tf));
+	qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
 	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
