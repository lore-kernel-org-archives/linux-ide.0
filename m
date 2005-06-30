From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: Fix failed assertion in ata_qc_complete()
Date: Thu, 30 Jun 2005 17:56:16 +0800
Message-ID: <42C3C1C0.2040501@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080806020704040101070506"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:11254 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262920AbVF3J43 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jun 2005 05:56:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080806020704040101070506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

(This is the patch #4 in the summary.)
Problem:
    'assert(qc->flags & ATA_QCFLAG_ACTIVE)' assertion failed in ata_pio_complete().

Root cause:
  Please see the detailed dmesg log in the follow-up mail.

Change:
- Reorder the clearing of the 'qc->flags &= ~ATA_QCFLAG_ACTIVE' flag to
   be _before_ 'qc->complete_fn(qc, drv_stat)' instead of _after_.
- Add a comment per Tejun's advice.

Attached please find the patch against the linux-2.6.git tree
(HEAD 9b4311eedb17fa88f02e4876cd6aa9a08e383cd6) for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


--------------080806020704040101070506
Content-Type: text/plain;
 name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.diff"

--- linux/drivers/scsi/libata-core.c.ori	2005-06-30 17:16:28.000000000 +0800
+++ linux/drivers/scsi/libata-core.c	2005-06-30 17:35:50.000000000 +0800
@@ -3086,9 +3086,14 @@
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
 
+	/* atapi: inactivate qc to prevent the interrupt handler from 
+	 * completing the command twice, before the scsi error handler
+	 * is called.
+	 */
+	qc->flags &= ~ATA_QCFLAG_ACTIVE;
+
 	/* call completion callback */
 	rc = qc->complete_fn(qc, drv_stat);
-	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately

--------------080806020704040101070506--


