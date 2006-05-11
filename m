From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/22] sata_sil24: update TF image only when necessary
Date: Thu, 11 May 2006 20:59:51 +0900
Message-ID: <11473487912480-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:49594 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751593AbWEKMAC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:02 -0400
Received: by py-out-1112.google.com with SMTP id f28so211124pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:02 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update TF image (pp->tf) only when necessary.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

9a79c598f88ccdb130416b67399194ac275af7b5
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index e9fd869..a9c8484 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -799,17 +799,9 @@ static inline void sil24_host_intr(struc
 		if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
 			writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
 
-		/*
-		 * !HOST_SSAT_ATTN guarantees successful completion,
-		 * so reading back tf registers is unnecessary for
-		 * most commands.  TODO: read tf registers for
-		 * commands which require these values on successful
-		 * completion (EXECUTE DEVICE DIAGNOSTIC, CHECK POWER,
-		 * DEVICE RESET and READ PORT MULTIPLIER (any more?).
-		 */
-		sil24_update_tf(ap);
-
 		if (qc) {
+			if (qc->flags & ATA_QCFLAG_RESULT_TF)
+				sil24_update_tf(ap);
 			qc->err_mask |= ac_err_mask(pp->tf.command);
 			ata_qc_complete(qc);
 		}
-- 
1.2.4


