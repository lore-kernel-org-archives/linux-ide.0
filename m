From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix WARN_ON() condition in *_fill_sg()
Date: Fri, 17 Feb 2006 14:15:44 +0900
Message-ID: <20060217051544.GA16684@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:38983 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932267AbWBQFPq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 00:15:46 -0500
Received: by zproxy.gmail.com with SMTP id l8so341614nzf
        for <linux-ide@vger.kernel.org>; Thu, 16 Feb 2006 21:15:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Raymond.Liu@siliconimage.com

For ATAPI commands, padding can reduce qc->n_elem by one and thus to
zero making WARN_ON(qc->n_elem == 0) in ata_fill_sg() and qs_fill_sg()
trigger for legal commands.  This patch fixes the WARN_ON() conditions
to take qc->pad_len into account.

Although the condition check seems a bit excessive, as this part of
code isn't still stable yet, I think it's worth to keep those.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, this patch is against the current #upstream[1].  Without this
patch trying to burn a cd with cdrecord on sii3114 results in a log of
Badness messages.  One of offending commands is MODE_SENSE(10) with
data size of 2 to find out mode page size.  Padding leaves no sg entry
and the Badness gets trigerred.

[1] f1b318793dcd2d9ff6b5ac06e7762098fa079cee

 libata-core.c |    2 +-
 sata_qstor.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 61cba39..f7fa69f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2639,7 +2639,7 @@ static void ata_fill_sg(struct ata_queue
 	unsigned int idx;
 
 	WARN_ON(qc->__sg == NULL);
-	WARN_ON(qc->n_elem == 0);
+	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
 
 	idx = 0;
 	ata_for_each_sg(sg, qc) {
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 2864826..9602f43 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -277,7 +277,7 @@ static unsigned int qs_fill_sg(struct at
 	u8 *prd = pp->pkt + QS_CPB_BYTES;
 
 	WARN_ON(qc->__sg == NULL);
-	WARN_ON(qc->n_elem == 0);
+	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
 
 	nelem = 0;
 	ata_for_each_sg(sg, qc) {
