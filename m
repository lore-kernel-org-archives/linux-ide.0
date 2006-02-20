From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: fix WARN_ON() condition in *_fill_sg()
Date: Mon, 20 Feb 2006 23:48:37 +0900
Message-ID: <11404469171463-git-send-email-htejun@gmail.com>
References: <43F9970F.9010903@pobox.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:50315 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030263AbWBTOsj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 09:48:39 -0500
Received: by pproxy.gmail.com with SMTP id f25so1129087pyf
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 06:48:39 -0800 (PST)
In-Reply-To: <43F9970F.9010903@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

For ATAPI commands, padding can reduce qc->n_elem by one and thus to
zero making assert(qc->n_elem > 0)'s in ata_fill_sg() and qs_fill_sg()
fail for legal commands.  This patch fixes the assert()'s to take
qc->pad_len into account.

Although the condition check seems a bit excessive, as this part of
code isn't still stable yet, I think it's worth to keep those.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 +-
 drivers/scsi/sata_qstor.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

cc1feb52b7a9a10c2438759d39e8649834e668fb
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7ddd5a6..bbac87a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2570,7 +2570,7 @@ static void ata_fill_sg(struct ata_queue
 	unsigned int idx;
 
 	assert(qc->__sg != NULL);
-	assert(qc->n_elem > 0);
+	assert(qc->n_elem > 0 || qc->pad_len > 0);
 
 	idx = 0;
 	ata_for_each_sg(sg, qc) {
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index de05e28..80480f0 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -277,7 +277,7 @@ static unsigned int qs_fill_sg(struct at
 	u8 *prd = pp->pkt + QS_CPB_BYTES;
 
 	assert(qc->__sg != NULL);
-	assert(qc->n_elem > 0);
+	assert(qc->n_elem > 0 || qc->pad_len > 0);
 
 	nelem = 0;
 	ata_for_each_sg(sg, qc) {
-- 
1.1.5


