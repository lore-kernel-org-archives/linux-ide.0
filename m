From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: fix qc->n_elem == 0 case handling in ata_qc_next_sg
Date: Mon, 20 Feb 2006 23:48:38 +0900
Message-ID: <11404469181458-git-send-email-htejun@gmail.com>
References: <43F9970F.9010903@pobox.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:30673 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030259AbWBTOsj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 09:48:39 -0500
Received: by zproxy.gmail.com with SMTP id 40so977623nzk
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 06:48:38 -0800 (PST)
In-Reply-To: <43F9970F.9010903@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch makes ata_for_each_sg() start with pad_sgent when
qc->n_elem is zero.  Previously, ata_for_each_sg() unconditionally
started with qc->__sg, handling the first sg to fill_sg() routines
even when the entry was invalid.  And while at it, unwind ?: in
ata_qc_next_sg() into if statement.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

940e8d008d8e53b532de8de994477baf78e7007a
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9e5db29..c91be5e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -557,17 +557,29 @@ ata_sg_is_last(struct scatterlist *sg, s
 }
 
 static inline struct scatterlist *
+ata_qc_first_sg(struct ata_queued_cmd *qc)
+{
+	if (qc->n_elem)
+		return qc->__sg;
+	if (qc->pad_len)
+		return &qc->pad_sgent;
+	return NULL;
+}
+
+static inline struct scatterlist *
 ata_qc_next_sg(struct scatterlist *sg, struct ata_queued_cmd *qc)
 {
 	if (sg == &qc->pad_sgent)
 		return NULL;
 	if (++sg - qc->__sg < qc->n_elem)
 		return sg;
-	return qc->pad_len ? &qc->pad_sgent : NULL;
+	if (qc->pad_len)
+		return &qc->pad_sgent;
+	return NULL;
 }
 
 #define ata_for_each_sg(sg, qc) \
-	for (sg = qc->__sg; sg; sg = ata_qc_next_sg(sg, qc))
+	for (sg = ata_qc_first_sg(qc); sg; sg = ata_qc_next_sg(sg, qc))
 
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
-- 
1.1.5


