From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: trivial updates to ata_sg_init_one()
Date: Tue, 14 Nov 2006 22:35:43 +0900
Message-ID: <20061114133543.GB27684@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.193]:55883 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965693AbWKNNfu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:35:50 -0500
Received: by nz-out-0102.google.com with SMTP id l1so970999nzf
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:35:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

There's no need to memset &qc->sgent manually, sg_init_one() clears
sgent inside it.  Also, kill not-so-necessary sg local variable.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9fdb266..994bc27 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3475,19 +3475,15 @@ void ata_noop_qc_prep(struct ata_queued_
 
 void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf, unsigned int buflen)
 {
-	struct scatterlist *sg;
-
 	qc->flags |= ATA_QCFLAG_SINGLE;
 
-	memset(&qc->sgent, 0, sizeof(qc->sgent));
 	qc->__sg = &qc->sgent;
 	qc->n_elem = 1;
 	qc->orig_n_elem = 1;
 	qc->buf_virt = buf;
 	qc->nbytes = buflen;
 
-	sg = qc->__sg;
-	sg_init_one(sg, buf, buflen);
+	sg_init_one(&qc->sgent, buf, buflen);
 }
 
 /**
-- 
1.4.3.3

