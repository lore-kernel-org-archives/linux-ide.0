From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/6] libata: Do not retry commands with valid autosense
Date: Fri, 31 Jul 2015 15:02:03 +0200
Message-ID: <1438347728-106434-2-git-send-email-hare@suse.de>
References: <1438347728-106434-1-git-send-email-hare@suse.de>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1438347728-106434-1-git-send-email-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, James Bottomley <james.bottomley@hansenpartnership.com>, Hannes Reinecke <hare@suse.de>
List-Id: linux-ide@vger.kernel.org

If a failed command has a valid autosense there is no need to
retry it on the ATA level; at best we're incurring the same
error again. So rather not retry it here, but leave it to
the SCSI layer to decide if a retry is in order.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7465031..1b4e9d1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2218,6 +2218,8 @@ static inline int ata_eh_worth_retry(struct ata_queued_cmd *qc)
 		return 1;	/* otherwise retry anything from fs stack */
 	if (qc->err_mask & AC_ERR_INVALID)
 		return 0;	/* don't retry these */
+	if (qc->flags & ATA_QCFLAG_SENSE_VALID)
+		return 0;	/* Autosense, no need to retry here */
 	return qc->err_mask != AC_ERR_DEV;  /* retry if not dev error */
 }
 
-- 
1.8.5.2

