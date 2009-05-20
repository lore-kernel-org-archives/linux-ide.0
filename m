From: Jens Axboe <jens.axboe@oracle.com>
Subject: [PATCH] libata: get rid of ATA_MAX_QUEUE loop in
	ata_qc_complete_multiple()
Date: Wed, 20 May 2009 08:57:52 +0200
Message-ID: <20090520065752.GC11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:45556 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbZETG5v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 02:57:51 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, htejun@gmail.com

Hi,

We very rarely (if ever) complete more than one command in the
sactive mask at the time, even for extremely high IO rates. So
looping over the entire range of possible tags is pointless,
instead use __ffs() to just find the completed tags directly.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
---
 drivers/ata/libata-core.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 17c5d48..8de0081 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5027,9 +5027,9 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
  */
 int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active)
 {
+	unsigned int i = 0;
 	int nr_done = 0;
 	u32 done_mask;
-	int i;
 
 	done_mask = ap->qc_active ^ qc_active;
 
@@ -5039,16 +5039,19 @@ int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < ATA_MAX_QUEUE; i++) {
+	while (done_mask) {
 		struct ata_queued_cmd *qc;
+		unsigned int next = __ffs(done_mask);
 
-		if (!(done_mask & (1 << i)))
-			continue;
-
-		if ((qc = ata_qc_from_tag(ap, i))) {
+		qc = ata_qc_from_tag(ap, i + next);
+		if (qc) {
 			ata_qc_complete(qc);
 			nr_done++;
 		}
+		if (++next >= ATA_MAX_QUEUE)
+			break;
+		i += next;
+		done_mask >>= next;
 	}
 
 	return nr_done;
-- 
1.6.3.rc0.1.gf800


-- 
Jens Axboe

