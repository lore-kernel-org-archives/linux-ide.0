From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix qc->n_elem == 0 case handling in ata_qc_next_sg
Date: Fri, 17 Feb 2006 16:59:07 +0900
Message-ID: <20060217075907.GB31835@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:11906 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932584AbWBQH7J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 02:59:09 -0500
Received: by pproxy.gmail.com with SMTP id n25so413235pyg
        for <linux-ide@vger.kernel.org>; Thu, 16 Feb 2006 23:59:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This patch makes ata_for_each_sg() start with pad_sgent when
qc->n_elem is zero.  Previously, ata_for_each_sg() unconditionally
started with qc->__sg, handling the first sg to fill_sg() routines
even when the entry was invalid.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch, combined with ata_sg_setup_one-trim_zero_length_sg
patch[1] I've just posted, makes sure that low level driver fill_sg()
routines don't receive zero length sg entry.  Tested with cdrecord and
small test program which uses SCSI_IOCTL_SEND_COMMAND (for single map
case).

 libata.h |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -616,17 +616,29 @@ ata_sg_is_last(struct scatterlist *sg, s
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
