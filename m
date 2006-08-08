From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: clear sdev->locked on door lock failure
Date: Tue, 8 Aug 2006 14:08:59 +0900
Message-ID: <20060808050859.GB28202@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.204]:48465 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750839AbWHHFJH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Aug 2006 01:09:07 -0400
Received: by nz-out-0102.google.com with SMTP id n1so241221nzf
        for <linux-ide@vger.kernel.org>; Mon, 07 Aug 2006 22:09:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: uchang@tw.ibm.com, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, garyhade@us.ibm.com

SCSI EH locks door if sdev->locked is set.  Sometimes door lock
command fails continuously (e.g. when medium is not present) and as
libata uses EH to acquire sense data, this easily creates a loop where
a failed lock door invokes EH and EH issues lock door on completion.

This patch clears sdev->locked on door lock failure to break this
loop.  This problem has been spotted and diagnosed by Unicorn Chang
<uchang@tw.ibm.com>.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 1638e57..f6ddfe6 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2353,6 +2353,19 @@ static void atapi_qc_complete(struct ata
 			ata_gen_ata_desc_sense(qc);
 		}
 
+		/* SCSI EH automatically locks door if sdev->locked is
+		 * set.  Sometimes door lock request continues to
+		 * fail, for example, when no media is present.  This
+		 * creates a loop - SCSI EH issues door lock which
+		 * fails and gets invoked again to acquire sense data
+		 * for the failed command.
+		 *
+		 * If door lock fails, always clear sdev->locked to
+		 * avoid this infinite loop.
+		 */
+		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL)
+			qc->dev->sdev->locked = 0;
+
 		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
 		qc->scsidone(cmd);
 		ata_qc_free(qc);
