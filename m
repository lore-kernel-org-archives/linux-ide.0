From: Jens Axboe <jens.axboe@oracle.com>
Subject: ibata: get rid of ATA_MAX_QUEUE loop in ata_qc_complete_multiple()
	v2
Date: Wed, 20 May 2009 09:44:39 +0200
Message-ID: <20090520074439.GJ11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:60910 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628AbZETHoi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 03:44:38 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com, jeff@garzik.org

We very rarely (if ever) complete more than one command in the
sactive mask at the time, even for extremely high IO rates. So
looping over the entire range of possible tags is pointless,
instead use __ffs() to just find the completed tags directly.

Updated to clear the tag from the done_mask instead of shifting
done_mask down as suggested by From: Tejun Heo <htejun@gmail.com>
Verified with a user space tester to produce the same results.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
---
 drivers/ata/libata-core.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c924230..ca4d208 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5031,7 +5031,6 @@ int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active)
 {
 	int nr_done = 0;
 	u32 done_mask;
-	int i;
 
 	done_mask = ap->qc_active ^ qc_active;
 
@@ -5041,16 +5040,16 @@ int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < ATA_MAX_QUEUE; i++) {
+	while (done_mask) {
 		struct ata_queued_cmd *qc;
+		unsigned int tag = __ffs(done_mask);
 
-		if (!(done_mask & (1 << i)))
-			continue;
-
-		if ((qc = ata_qc_from_tag(ap, i))) {
+		qc = ata_qc_from_tag(ap, tag);
+		if (qc) {
 			ata_qc_complete(qc);
 			nr_done++;
 		}
+		done_mask &= ~(1 << tag);
 	}
 
 	return nr_done;
-- 
1.6.3.rc0.1.gf800

-- 
Jens Axboe

